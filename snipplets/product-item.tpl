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
		{# Main info container with rigid vertical alignment #}
		<div class="flex-grow flex flex-col pt-3 pb-2 px-1">
			
			{# Row 1: Title (Fixed height for 2 lines) #}
			<div class="min-h-[40px] mb-2">
				<a href="{{ product.url }}" title="{{ product.name }}" class="block">
					<h3 class="text-[13px] font-extrabold text-slate-800 leading-tight uppercase tracking-tighter line-clamp-2">{{ product.name }}</h3>
				</a>
			</div>

			{# Row 2: Pricing & Installments (Fixed baseline) #}
			<div class="min-h-[44px] mb-3">
				<div class="flex items-baseline gap-2 mb-0.5">
					{% if product.compare_at_price > product.price %}
						<span class="text-xs text-slate-400 line-through font-bold">{{ product.compare_at_price | money }}</span>
					{% endif %}
					<span class="text-[19px] font-black text-primary tracking-tighter">{{ product.price | money }}</span>
				</div>
				{% if product.installments %}
					<div class="text-[11px] text-slate-500 font-medium">
						{{ product.installments.amount }} x {{ product.installments.installment_amount | money }} {{ product.installments.has_no_interest ? 'sin interés' : '' }}
					</div>
				{% endif %}
			</div>

			{# Row 3: Swatches & Color Name #}
			<div class="min-h-[52px] mb-3">
				{% if product.variations %}
					<div class="js-color-swatches flex flex-wrap gap-2 mb-1.5" data-product-id="{{ product.id }}">
						{% for variation in product.variations if variation.name | lower in ['color', 'cor', 'colores', 'cores'] %}
							{% for option in variation.options %}
								{% set variant_for_color = false %}
								{% for v in product.variants if v.option1 == option.id or v.option2 == option.id or v.option3 == option.id %}
									{% if not variant_for_color %}
										{% set variant_for_color = v %}
									{% endif %}
								{% endfor %}
								{% set color_available = variant_for_color and variant_for_color.available %}
								<button
									class="js-variant-swatch relative rounded-full transition-all flex items-center justify-center
										{% if color_available %}cursor-pointer{% else %}opacity-20 cursor-not-allowed{% endif %}"
									title="{{ option.name }}{% if not color_available %} — Sin stock{% endif %}"
									{% if variant_for_color %}
										data-variant-id="{{ variant_for_color.id }}"
										data-variant-image="{{ variant_for_color.featured_image.src | default(product.featured_image.src) }}"
										data-color-name="{{ option.name }}"
									{% endif %}
									{% if not color_available %}disabled aria-disabled="true"{% endif %}
								>
									<div class="w-full h-full rounded-full" style="background-color: {{ option.custom_data | default('#cccccc') }};"></div>
									{% if not color_available %}
										<div class="absolute inset-0 flex items-center justify-center rotate-45 pointer-events-none">
											<div class="w-full h-[1.5px] bg-slate-900 rounded-full"></div>
										</div>
									{% endif %}
								</button>
							{% endfor %}
						{% endfor %}
					</div>

					{# Selected color name label #}
					{% for variation in product.variations if variation.name | lower in ['color', 'cor', 'colores', 'cores'] %}
						<p class="js-selected-color-name text-[9px] text-slate-400 font-bold uppercase tracking-wider">
							{{ variation.options.first.name }}
						</p>
					{% endfor %}
				{% endif %}
			</div>

			{# Row 4: Savings Box (Aligned at the same level) #}
			<div class="mt-auto">
				{% if product.compare_at_price > product.price or product.maxPaymentDiscount.value > 0 %}
					{% set price_diff = product.compare_at_price > product.price ? (product.compare_at_price - product.price) : 0 %}
					{% set payment_diff = product.price * (product.maxPaymentDiscount.value / 100) %}
					<div class="mb-4 px-3 py-1.5 bg-[#22c55e]/10 border border-[#22c55e]/20 rounded flex items-center justify-between gap-2">
						<div class="flex items-center gap-1.5 text-[8px] uppercase font-black text-[#22c55e] tracking-tight">
							<span class="material-symbols-outlined text-[13px]">check_circle</span>
							AHORRO
						</div>
						<span class="text-[15px] font-black text-[#22c55e] tracking-tight">{{ (price_diff + payment_diff) | money }}</span>
					</div>
				{% else %}
					<div class="mb-4 h-[38px]"></div>
				{% endif %}

				{# Buy Button: Pushed to bottom #}
				<form action="{{ store.cart_url }}" method="post" class="js-product-form js-quick-add-form" data-store="product-item-{{ product.id }}">
					<input type="hidden" name="add_to_cart" value="{{ product.variants.first.id }}" class="js-variant-input">
					<button type="submit" class="js-addtocart js-prod-submit-form w-full bg-primary text-white font-black py-3 rounded-lg flex items-center justify-center gap-2 hover:brightness-110 transition-all text-[11px] uppercase tracking-widest">
						<span class="material-symbols-outlined text-lg">shopping_cart</span> {{ 'AGREGAR' | translate }}
					</button>
				</form>
			</div>
		</div>
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
			item: 'js-product-container js-item-product h-full flex flex-col ' ~ item_spacing_classes ~ slide_item_class ~ reduced_item_classes,
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
					'<span class="bg-[#111827] text-white text-[11px] font-black px-3 py-1.5 rounded-sm uppercase tracking-tighter shadow-md border border-white/10">' ~ (((product.compare_at_price - product.price) / product.compare_at_price * 100) | round) ~ '% OFF</span>' ~
					'<span class="bg-[#16a34a] text-white text-[11px] font-black px-3 py-2 rounded-sm uppercase tracking-tighter shadow-md border border-white/10 leading-[1.1] text-center">' ~ ("AHORRÁS" | translate) ~ '<br><span class="text-[17px] tracking-tighter">$' ~ (product.compare_at_price_raw - product.price_raw) | number_format(0, ',', '.') ~ '</span></span>'
				 : '') ~
				(product.maxPaymentDiscount.value > 0 ? '<span class="bg-[#1a202c] text-white text-[9px] font-black px-2 py-1 rounded-sm uppercase tracking-tighter shadow-md border border-white/5">+' ~ product.maxPaymentDiscount.value ~ '% OFF EXTRA</span>' : '') ~
				'</div>' : '',
		},
	})
}}