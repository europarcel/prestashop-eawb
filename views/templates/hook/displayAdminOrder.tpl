{*
 * EuroParcel Admin Order Display Template
 *
 * @author    EuroParcel
 * @copyright Copyright (c) 2025 EuroParcel
 * @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *}
<div class="card mt-2 europarcel-admin-info">
    <div class="card-header">
        <h3 class="card-header-title">
            <img src="{$europarcel_logo|escape:'html':'UTF-8'}" width="84" height="24" alt="eAWB">
        </h3>
    </div>
    <div class="card-body">
        <p class="mb-1">
            <strong>{l s='Courier:' mod='europarcel'}</strong>
            {$europarcel_courier|escape:'html':'UTF-8'}
        </p>
        <p class="mb-1">
            <strong>{l s='Service:' mod='europarcel'}</strong>
            {if $europarcel_is_locker_service}{l s='Delivery to locker' mod='europarcel'}{else}{l s='Delivery to home' mod='europarcel'}{/if}
        </p>
        {if $europarcel_locker && $europarcel_locker.name}
            <p class="mb-1">
                {if $europarcel_locker_network}
                    <img src="{$europarcel_locker_network.logo|escape:'html':'UTF-8'}" width="60" height="30" alt="{$europarcel_locker_network.name|escape:'html':'UTF-8'}">
                {/if}
                <strong>{$europarcel_locker.name|escape:'html':'UTF-8'}</strong>
            </p>
            <p class="mb-1">{$europarcel_locker.address|escape:'html':'UTF-8'}</p>
        {/if}
        {if $europarcel_locker_id}
            <p class="mb-0">
                <strong>{l s='Locker id:' mod='europarcel'}</strong>
                {$europarcel_locker_id|intval}
            </p>
        {/if}
    </div>
</div>
