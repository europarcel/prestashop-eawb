{*
 * EuroParcel Order Confirmation Template
 *
 * @author    EuroParcel
 * @copyright Copyright (c) 2025 EuroParcel
 * @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *}
<div class="europarcel-order-confirmation">
    <div class="alert alert-info">
        <h4>{l s='Locker information' mod='europarcel'}</h4>
        {if $europarcel_locker_network}
            <img class="europarcel-locker-logo" src="{$europarcel_locker_network.logo|escape:'html':'UTF-8'}" width="80" height="40" alt="{$europarcel_locker_network.name|escape:'html':'UTF-8'}">
        {/if}
        {if $europarcel_locker.name}
            <p class="mb-1">{$europarcel_locker.name|escape:'html':'UTF-8'}</p>
            <p class="mb-0">{$europarcel_locker.address|escape:'html':'UTF-8'}</p>
        {/if}
    </div>
</div>
