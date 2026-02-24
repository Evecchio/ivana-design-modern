{# Cart item snippet refined with premium Tailwind styling #}
{% set item_type_classes = item.product.is_non_shippable ? 'js-cart-item-non-shippable' : 'js-cart-item-shippable' %}

<div class="js-cart-item {{ item_type_classes }} flex gap-4 pb-6 mb-6 border-b border-slate-100 dark:border-slate-800 last:border-0 last:pb-0" data-item-id="{{ item.id }}" data-store="cart-item-{{ item.product.id }}" data-component="cart.line-item">

    {# Item Image #}
    <div class="w-20 h-20 md:w-24 md:h-24 flex-shrink-0 bg-slate-50 dark:bg-slate-900 rounded-xl overflow-hidden shadow-sm border border-slate-100 dark:border-slate-800">
        <a href="{{ item.url }}" class="block w-full h-full">
            {{ component('image', {
                image_name: item.featured_image,
                image_classes: 'w-full h-full object-cover',
                image_alt: item.short_name,
                product_image: true,
            }) }}
        </a>
    </div>

    {# Item Info #}
    <div class="flex-1 flex flex-col md:flex-row md:items-center gap-2 md:gap-4">
        <div class="flex-1 min-w-0">
            <a href="{{ item.url }}" class="block mb-0.5 group">
                <h4 class="text-sm font-black text-slate-900 dark:text-white uppercase tracking-tighter group-hover:text-primary transition-colors truncate">
                    {{ item.short_name }}
                </h4>
            </a>
            
            {% if item.short_variant_name %}
                <span class="inline-block px-2 py-0.5 bg-slate-100 dark:bg-slate-800 text-[10px] font-bold text-slate-500 rounded uppercase tracking-widest mb-2">
                    {{ item.short_variant_name }}
                </span>
            {% endif %}

            {# Delete Action #}
            <button type="button" class="block w-fit text-[10px] font-black uppercase tracking-widest text-slate-400 hover:text-red-500 transition-colors" onclick="LS.removeItem({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="line-item.remove">
                {{ "Eliminar" | translate }}
            </button>
        </div>

        {# Quantity & Price Controls #}
        <div class="flex items-center justify-between md:justify-end gap-4 md:gap-8">
            
            {# Quantity Select #}
            <div class="flex items-center bg-slate-100 dark:bg-slate-800 rounded-full h-9 px-1">
                <button class="w-7 h-7 flex items-center justify-center text-slate-500 hover:text-primary transition-colors" onclick="LS.minusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})">
                    <span class="material-symbols-outlined text-base">remove</span>
                </button>
                <input type="number" class="w-8 bg-transparent text-center text-xs font-black text-slate-900 dark:text-white border-none focus:ring-0 p-0" value="{{ item.quantity }}" readonly>
                <button class="w-7 h-7 flex items-center justify-center text-slate-500 hover:text-primary transition-colors" onclick="LS.plusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})">
                    <span class="material-symbols-outlined text-base">add</span>
                </button>
            </div>

            {# Prices #}
            <div class="text-right flex flex-col items-end min-w-[80px]">
                {% if item.compare_at_price_subtotal > item.subtotal %}
                    <span class="text-[10px] text-slate-400 line-through font-bold">
                        {{ item.compare_at_price_subtotal | money }}
                    </span>
                {% endif %}
                <span class="js-cart-item-subtotal text-sm font-black text-slate-900 dark:text-white">
                    {{ item.subtotal | money }}
                </span>
            </div>
        </div>
    </div>
</div>
    