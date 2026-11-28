<?php

/**
 * EuroParcel - PrestaShop Shipping Module
 *
 * @author    EuroParcel
 * @copyright Copyright (c) 2025 EuroParcel
 * @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 */
if (!defined('_PS_VERSION_')) {
    exit;
}

/**
 * Move the carriers to the eAWB name and logo, keep each order's locker, and show it on the customer's order details.
 * A carrier name or logo the merchant changed stays.
 *
 * @param EuroParcel $module
 *
 * @return bool
 */
function upgrade_module_2_5_0($module)
{
    $names = [
        'EuroParcel - Home Delivery' => 'eAWB - Home Delivery',
        'EuroParcel Locker Delivery' => 'eAWB Locker Delivery',
    ];

    foreach ($names as $oldName => $newName) {
        Db::getInstance()->update(
            'carrier',
            ['name' => pSQL($newName)],
            'external_module_name = \'' . pSQL($module->name) . '\' AND deleted = 0 AND name = \'' . pSQL($oldName) . '\''
        );
    }

    // md5 of the logo.png that versions 1.0.1 to 1.0.4, and 1.0.5 to 2.0.0, copied to their carriers
    $shippedLogoMd5s = ['35ceb681a09ea6b63c2a5bb56c314f4a', '0095bee976c534d222f4bd92ec720434'];
    $newLogo = dirname(__FILE__) . '/../logo.png';

    $sql = new DbQuery();
    $sql->select('id_carrier')
        ->from('carrier')
        ->where('external_module_name = \'' . pSQL($module->name) . '\'')
        ->where('deleted = 0');

    foreach (Db::getInstance()->executeS($sql) ?: [] as $carrier) {
        $idCarrier = (int) $carrier['id_carrier'];
        $logo = _PS_SHIP_IMG_DIR_ . $idCarrier . '.jpg';

        if (!file_exists($logo) || !in_array(md5_file($logo), $shippedLogoMd5s, true) || !@copy($newLogo, $logo)) {
            continue;
        }

        // The admin carrier list caches a thumbnail of each carrier logo; drop it so the list shows the new logo
        foreach (['', '_*'] as $shopSuffix) {
            foreach (glob(_PS_TMP_IMG_DIR_ . 'carrier_mini_' . $idCarrier . $shopSuffix . '.jpg') ?: [] as $thumbnail) {
                @unlink($thumbnail);
            }
        }
    }

    return $module->installOrderLockerTable()
        && $module->registerHook('displayOrderDetail', Shop::getShops(true, null, true));
}
