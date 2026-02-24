<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="{% for language in languages %}{% if language.active %}{{ language.lang }}{% endif %}{% endfor %}">
	<head>

		{{ component('head-tags') }}

		<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
		<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet"/>
		<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap" rel="stylesheet"/>
		<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
		<script id="tailwind-config">
			tailwind.config = {
				darkMode: "class",
				theme: {
					extend: {
						colors: {
							"primary": "#ee4b2b",
							"background-light": "#f8f6f6",
							"background-dark": "#221310",
						},
						fontFamily: {
							"display": ["Manrope", "sans-serif"]
						},
						borderRadius: {"DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px"},
					},
				},
			}
		</script>
		<style>
			.no-scrollbar::-webkit-scrollbar { display: none; }
			.no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
		</style>
		<script>
			document.addEventListener('DOMContentLoaded', () => {
				document.querySelectorAll('.js-variant-swatch').forEach(swatch => {
					swatch.addEventListener('click', (e) => {
						e.preventDefault();
						const variantId = swatch.getAttribute('data-variant-id');
						const productContainer = swatch.closest('.group');
						const variantInput = productContainer.querySelector('.js-variant-input');
						
						// Update input
						if (variantInput) {
							variantInput.value = variantId;
							// If LS (TiendaNube scripts) is available, we might need to trigger a change
							if (window.LS && LS.variants) {
								// Placeholder for any specific TiendaNube variant update logic if needed
							}
						}

						// Visual feedback
						productContainer.querySelectorAll('.js-variant-swatch').forEach(s => {
							s.classList.remove('border-primary', 'scale-110');
							s.classList.add('border-slate-200', 'dark:border-slate-700');
						});
						swatch.classList.add('border-primary', 'scale-110');
						swatch.classList.remove('border-slate-200', 'dark:border-slate-700');
					});
				});
			});
		</script>

		<link rel="preconnect" href="https://fonts.googleapis.com" />
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
		
		{# Preload LCP home, category and product page elements #}

		{% snipplet 'preload-images.tpl' %}

		<link rel="preload" as="style" href="{{ [settings.font_headings, settings.font_rest] | google_fonts_url('400,700') }}" />
		<link rel="preload" href="{{ 'css/style-critical.scss' | static_url }}" as="style" />
		<link rel="preload" href="{{ 'css/style-utilities.scss' | static_url }}" as="style" />
		<link rel="preload" href="{{ 'js/external-no-dependencies.js.tpl' | static_url }}" as="script" />

		{#/*============================================================================
			#CSS and fonts
		==============================================================================*/#}

		<style>
			{# Font families #}

			{{ component(
				'fonts',{
					font_weights: '400,700',
					font_settings: 'settings.font_headings, settings.font_rest'
				})
			}}

			{# General CSS Tokens #}

			{% include "static/css/style-tokens.tpl" %}
		</style>

		{# Critical CSS #}

		{{ 'css/style-critical.scss' | static_url | static_inline }}
		{{ 'css/style-utilities.scss' | static_url | static_inline }}

		{# Load async styling not mandatory for first meaningfull paint #}

		<link rel="stylesheet" href="{{ 'css/style-async.scss' | static_url }}" media="print" onload="this.media='all'">

		{# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}

		<style>
			{{ settings.css_code | raw }}
			{# Force hide "Más colores" overlay and other unwanted messages #}
			.product-item-more-images-message,
			.item-more-images-message,
			.js-item-more-images-message,
			[class*="more-images"],
			[class*="more-colors"] {
				display: none !important;
				visibility: hidden !important;
				opacity: 0 !important;
				pointer-events: none !important;
			}
		</style>

		{#/*============================================================================
			#Javascript: Needed before HTML loads
		==============================================================================*/#}

		{# Defines if async JS will be used by using script_tag(true) #}

		{% set async_js = true %}

		{# Defines the usage of jquery loaded below, if nojquery = true is deleted it will fallback to jquery 1.5 #}

		{% set nojquery = true %}

		{# Jquery async by adding script_tag(true) #}

		{% if load_jquery %}

			{{ '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js' | script_tag(true) }}

		{% endif %}

		{# Loads private Tiendanube JS #}

		{% head_content %}

		{# Structured data to provide information for Google about the page content #}

		{{ component('structured-data') }}

	</head>
	<body class="{% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">

		{# Theme icons #}

		{% include "snipplets/svg/icons.tpl" %}

		{# Back to admin bar #}

		{{back_to_admin}}

		{# Header #}

		{% snipplet "header/header.tpl" %}

		{# Page content #}

		{% template_content %}

		{# Quickshop modal #}

		{% snipplet "grid/quick-shop.tpl" %}

		{# WhatsApp chat button #}

		{% snipplet "whatsapp-chat.tpl" %}

		{# Footer #}

		{% snipplet "footer/footer.tpl" %}

		{% if cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

			{# Minimum used for free shipping progress messages. Located on header so it can be accesed everywhere with shipping calculator active or inactive #}

			<span class="js-ship-free-min hidden" data-pricemin="{{ cart.free_shipping.min_price_free_shipping.min_price_raw }}"></span>
			<span class="js-free-shipping-config hidden" data-config="{{ cart.free_shipping.allFreeConfigurations }}"></span>
			<span class="js-cart-subtotal hidden" data-priceraw="{{ cart.subtotal }}"></span>
			<span class="js-cart-discount hidden" data-priceraw="{{ cart.promotional_discount_amount }}"></span>
		{% endif %}

		{#/*============================================================================
			#Javascript: Needed after HTML loads
		==============================================================================*/#}

		{# Javascript used in the store #}

		{# Critical libraries #}

		{{ 'js/external-no-dependencies.js.tpl' | static_url | script_tag }}

		<script type="text/javascript">

			LS.ready.then(function(){

				{# Non critical libraries #}

				{% include "static/js/external.js.tpl" %}

				{# Specific store JS functions: product variants, cart, shipping, etc #}

				{% include "static/js/store.js.tpl" %}

			});

		</script>

		{# Google survey JS for Tiendanube Survey #}

		{{ component('google-survey') }}

		{# Store external codes added from admin #}

		{% if store.assorted_js %}
			<script>
				LS.ready.then(function() {
					var trackingCode = jQueryNuvem.parseHTML('{{ store.assorted_js| escape("js") }}', document, true);
					jQueryNuvem('body').append(trackingCode);
				});
			</script>
		{% endif %}
	</body>
</html>
