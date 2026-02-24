{% set show_installments_settings_value = (settings.product_installments ? true : false) and not reduced_item %}
{% set show_color_variants_settings_value = (settings.product_color_variants ? true : false) and not reduced_item %}
{% set show_quick_shop_settings_value = (settings.quick_shop ? true : false) and not reduced_item %}
{% set show_secondary_image_settings_value = settings.product_hover ? true : false %}
{% set labels_value = reduced_item ? false : true %}
{% set price_compare_value = reduced_item ? false : true %}
{% set discount_rate_value = reduced_item ? false : true %}
{% set slide_item = slide_item | default(false) %}
{% set slide_item_class = slide_item ? 'js-item-slide swiper-slide ' %}
{% set reduced_item_classes = reduced_item ? 'product-item-reduced' %}
{% set item_name_classes = reduced_item ? 'mb-2' : 'mb-3' %}
{% set item_price_classes = reduced_item ? 'font-medium' %}
{% set item_spacing_classes = not reduced_item ? 'mb-3' %}
{% set slide_item_quick_shop_modal_trigger_class = slide_item ? ' js-quickshop-slide' %}
{% set modal_trigger_data = "#quickshop-modal" %}

{# Item image slider #}

{% set show_image_slider = 
    (template == 'category' or template == 'search')
    and settings.product_item_slider 
    and not reduced_item
    and not slide_item
    and not has_filters
    and product.other_images
%}

{% if show_image_slider %}
    {% set slider_controls_container_class = 'product-item-slider-controls-container svg-icon-text d-none d-md-block' %}
    {% set control_next_svg_id = 'arrow-long' %}
    {% set control_prev_svg_id = 'arrow-long' %}
{% endif %}

{% set image_classes = 'img-absolute img-absolute-centered fade-in' %}
{% set data_expand = show_image_slider ? '50' %}

{% set custom_content %}
	{% if not reduced_item %}
		{# Product Info: Name & Price #}
		<div class="mb-3">
			<a href="{{ product.url }}" title="{{ product.name }}" class="block mb-1">
				<h3 class="text-sm font-extrabold text-slate-900 dark:text-white leading-tight text-balance uppercase tracking-tighter">{{ product.name }}</h3>
			</a>
			<div class="flex items-baseline gap-2">
				<span class="text-lg font-black text-primary">{{ product.price | money }}</span>
				{% if product.compare_at_price > product.price %}
					<span class="text-xs text-slate-400 line-through font-bold">{{ product.compare_at_price | money }}</span>
				{% endif %}
			</div>
		</div>

		{# Variations / Colors Swatches - Solid Colors Only #}
		{% if product.variations %}
			<div class="flex flex-wrap gap-1.5 mb-4">
				{% for variation in product.variations if variation.name | lower in ['color', 'cor', 'colores', 'cores'] %}
					{% for option in variation.options %}
						{% set variant_for_color = false %}
						{% for v in product.variants if v.option1 == option.id or v.option2 == option.id or v.option3 == option.id %}
							{% if not variant_for_color %}
								{% set variant_for_color = v %}
							{% endif %}
						{% endfor %}
						<button 
							class="js-variant-swatch w-6 h-6 rounded-full border-2 border-slate-200 dark:border-slate-800 p-0.5 hover:border-primary transition-all cursor-pointer flex items-center justify-center {% if loop.first %}border-primary scale-110{% endif %}" 
							title="{{ option.name }}"
							{% if variant_for_color %}data-variant-id="{{ variant_for_color.id }}"{% endif %}
						>
							<div class="w-full h-full rounded-full" style="background-color: {{ option.custom_data | default('#ccc') }}; border: 1px solid rgba(0,0,0,0.1);"></div>
						</button>
					{% endfor %}
				{% endfor %}
			</div>
		{% endif %}

		{# Savings Detail - Moved Above the Button #}
		{% if product.compare_at_price > product.price or product.maxPaymentDiscount.value > 0 %}
			<div class="mb-3 p-2.5 bg-green-50/50 dark:bg-green-900/10 rounded-lg border border-green-100/50 dark:border-green-800/30">
				<div class="text-[9px] uppercase font-black text-green-700 dark:text-green-400 tracking-tighter">
					{% set price_diff = product.compare_at_price > product.price ? (product.compare_at_price - product.price) : 0 %}
					{% set payment_diff = product.price * (product.maxPaymentDiscount.value / 100) %}
					<div class="flex items-center gap-1 mb-0.5">
						<span class="material-symbols-outlined text-[12px]">verified</span>
						{{ 'Oportunidad de ahorro' | translate }}
					</div>
					<div class="text-xs text-green-800 dark:text-green-300">{{ 'Total:' | translate }} <span class="font-black underline underline-offset-2">{{ (price_diff + payment_diff) | money }}</span></div>
				</div>
			</div>
		{% endif %}

		{# Quick Add Form / Buy Button #}
		<form action="{{ store.cart_url }}" method="post" class="js-product-form js-quick-add-form mb-4" data-store="product-item-{{ product.id }}">
			<input type="hidden" name="add_to_cart" value="{{ product.variants.first.id }}" class="js-variant-input">
			<button type="submit" class="js-addtocart js-prod-submit-form w-full bg-slate-900 dark:bg-primary text-white font-extrabold py-3 rounded-lg flex items-center justify-center gap-2 hover:bg-primary dark:hover:bg-white dark:hover:text-primary transition-all text-xs uppercase tracking-widest shadow-lg shadow-black/5">
				<span class="material-symbols-outlined text-base">add_shopping_cart</span> {{ 'Agregar' | translate }}
			</button>
		</form>
		{{ component('subscriptions/subscription-message', {
			subscription_classes: {
				container: 'd-flex font-small font-md-normal text-accent font-weight-bold mt-2',
				icon: 'icon-inline icon-lg svg-icon-accent mr-1',
			},
			subscription_icon: true,
			subscription_icon_svg_id: 'returns-alt',
		}) }}
		{% set product_available_with_price = product.available and product.display_price %}

		{% if settings.last_product_category and product_available_with_price %}
			<div class="{% if product.variations %}js-last-product {% endif %}text-stock font-small mt-2"{% if product.selected_or_first_available_variant.stock != 1 %} style="display: none;"{% endif %}>
				{{ settings.last_product_text }}
			</div>
			{% if settings.latest_products_available %}
				{% set latest_products_limit = settings.latest_products_available %}
				<div class="{% if product.variations %}js-latest-products-available {% endif %}text-stock font-small mt-2" data-limit="{{ latest_products_limit }}" {% if product.selected_or_first_available_variant.stock > latest_products_limit or product.selected_or_first_available_variant.stock == null or product.selected_or_first_available_variant.stock == 1 %} style="display: none;"{% endif %}>
					{{ "¡Solo quedan" | translate }} <span class="js-product-stock">{{ product.selected_or_first_available_variant.stock }}</span> {{ "en stock!" | translate }}
				</div>
			{% endif %}
		{% endif %}

		{% if 
			((settings.quick_shop and not product.isSubscribable()) or settings.product_color_variants)
			and product.available 
			and product.display_price 
			and product.variations 
		%}

	        {# Hidden product form to update item image and variants: Also this is used for quickshop popup #}

	        <div class="js-item-variants hidden">
	            <form class="js-product-form" method="post" action="{{ store.cart_url }}">
	                <input type="hidden" name="add_to_cart" value="{{product.id}}" />
	                {% if product.variations %}
	                    {% include "snipplets/product/product-variants.tpl" with {quickshop: true} %}
	                {% endif %}
	                {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
	                {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

	                {# Add to cart CTA #}

	                {% set show_product_quantity = product.available and product.display_price %}

	                <div class="{% if show_product_quantity %}grid grid-auto-1{% endif %} mb-4">

	                    {% if show_product_quantity %}
	                        {% include "snipplets/product/product-quantity.tpl" with {quickshop: true} %}
	                    {% endif %}

	                    <div class="cart-button-container">

	                        <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary w-100 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />

	                        {# Fake add to cart CTA visible during add to cart event #}

	                        {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: 'w-100'} %}
	                    </div>
	                </div>
	            </form>
	        </div>

	    {% endif %}
    {% endif %}
{% endset %}

{{ component(
	'product-item', {
		secondary_image: show_secondary_image_settings_value,
		image_slider: show_image_slider,
		image_slider_pagination_container: true,
		installments: show_installments_settings_value,
		color_variants: show_color_variants_settings_value,
		quick_shop: show_quick_shop_settings_value,
		modal_trigger_data: 'data-target=' ~ modal_trigger_data,
		image_sizes: '(min-width: 768px) 50vw, 100vw',
		image_lazy: true,
		image_lazy_js: true,
		image_data_expand: data_expand,
		product_item_free_shipping_only: true,
		product_item_no_stock_only: true,
		product_item_free_shipping_short_wording: true,
		discount_rate: discount_rate_value,
		labels: labels_value,
		price_compare: price_compare_value,
		product_item_classes: {
			item: 'js-product-container js-item-product ' ~ item_spacing_classes ~ slide_item_class ~ reduced_item_classes,
			name: 'hidden',
			image: image_classes,
			information: 'd-flex flex-column pt-3 pb-2 text-left',
			price: 'hidden',
			price_compare: 'order-first mb-1',
			discount_rate: 'product-item-discount text-accent font-medium ml-2',
			installments: 'custom-installments mt-1',
			labels_group: 'product-labels',
			label_shipping: 'shipping-label',
			label_no_stock: 'mb-2',
			color: 'order-first',
			color_bullet: 'js-variation-option js-color-variant',
			quick_shop: 'js-item-submit-container mt-3',
			quick_shop_modal_trigger: ((not product.isSubscribable() ? 'js-modal-open-private js-quickshop-modal-open ' ) ~ 'btn btn-primary btn-small' ~ slide_item_quick_shop_modal_trigger_class),
			quick_shop_submit_container: 'position-relative',
			quick_shop_button: 'js-prod-submit-form btn btn-primary btn-small',
			image_slider_container: 'swiper-container position-absolute h-100 w-100',
			image_slider_wrapper: 'swiper-wrapper',
			image_slider_control_pagination_container: 'd-md-none',
			image_slider_slide: 'swiper-slide',
			image_slider_control: 'icon-inline icon-30px',
			image_slider_control_prev_container: 'swiper-button-prev ' ~ slider_controls_container_class,
			image_slider_control_prev: 'icon-flip-horizontal',
			image_slider_control_next_container: 'swiper-button-next ' ~ slider_controls_container_class,
			more_images_message: 'js-item-more-images-message',
		},
		image_control_next_svg_id: control_next_svg_id,
		image_control_prev_svg_id: control_prev_svg_id,
		content: {
			button_placeholder: include('snipplets/placeholders/button-placeholder.tpl', {direct_add: true, custom_class: 'text-left'}),
		},
		custom_content: {
			information: custom_content,
			image: (product.compare_at_price > product.price or product.maxPaymentDiscount.value > 0 or product.has_percentage_discount) ? '<div class="absolute top-2 right-2 z-20 flex flex-col gap-1 items-end pointer-events-none">' ~ 
				(product.compare_at_price > product.price ? 
					'<span class="bg-primary text-white text-[11px] font-black px-2.5 py-1.5 rounded uppercase tracking-tighter shadow-md border border-white/20">' ~ (((product.compare_at_price - product.price) / product.compare_at_price * 100) | round) ~ '% OFF</span>' ~
					'<span class="bg-green-600 text-white text-[11px] font-black px-2.5 py-1.5 rounded uppercase tracking-tighter shadow-md border border-white/20">' ~ ("Ahorrás" | translate) ~ " " ~ (product.compare_at_price - product.price) | money ~ '</span>'
				 : '') ~
				(product.maxPaymentDiscount.value > 0 ? '<span class="bg-slate-900/90 text-white text-[10px] font-black px-2 py-1 rounded uppercase tracking-tighter shadow-md border border-white/10">+' ~ product.maxPaymentDiscount.value ~ '% ' ~ ("OFF Extra" | translate) ~ '</span>' : '') ~
				'</div>' : '',
		},
	})
}}