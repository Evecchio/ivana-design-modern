{% if home_main_product %}
	{% set has_multiple_slides = product.images_count > 1 %}
{% else %}
	{% set has_multiple_slides = product.images_count > 1 or product.video_url %}
{% endif %}

{% if product.images_count > 0 %}
	<div class="product-images-slider position-relative mb-md-0 mb-3{% if not has_multiple_slides %} w-100{% endif %}">
		{{ component(
			'labels', {
				no_stock_only: true,
				labels_classes: {
					group: 'product-labels',
				},
			})
		}}
		<div class="js-swiper-product swiper-container" data-product-images-amount="{{ product.images_count }}">
			<div class="swiper-wrapper">
				{% for image in product.images %}
					<div class="js-product-slide swiper-slide slider-slide" data-image="{{image.id}}" data-image-position="{{loop.index0}}">
						{% if home_main_product %}
							<div class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ image.dimensions['height'] / image.dimensions['width'] * 100}}%;">
						{% else %}
							<a href="{{ image | product_image_url('original') }}" data-fancybox="product-gallery" class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ image.dimensions['height'] / image.dimensions['width'] * 100}}%;">
						{% endif %}

							{% set image_priority_high_value = not home_main_product and loop.first %}

							{{ component(
								'image', {
									image_priority_high: image_priority_high_value,
									src: image | product_image_url('original'),
									image_name: image,
									image_width: image.dimensions.width,
									image_height: image.dimensions.height,
									image_classes: 'js-product-slide-img product-slider-image img-absolute img-absolute-centered',
									image_alt: image.alt,
									product_image: true,
								})
							}}
						{% if home_main_product %}
							</div>
						{% else %}
							</a>
						{% endif %}
					</div>
				{% endfor %}
				{% if not home_main_product %}
					{% include 'snipplets/product/product-video.tpl' %}
				{% endif %}
			</div>
		</div>
		{% if has_multiple_slides %}
			<div class="js-swiper-product-pagination swiper-fractions text-right"></div>
		{% endif %}
	</div>
{% endif %}
{% if has_multiple_slides %}
	<div class="product-images-thumbs order-md-first text-md-center">
		<div class="js-swiper-product-thumbs swiper-product-thumb overflow-none mb-3"> 
			<div class="swiper-wrapper">
				{% for image in product.images %}
					<div class="swiper-slide product-thumb-container">
						{% include 'snipplets/product/product-image-thumb.tpl' %}
					</div>
				{% endfor %}
				{% if not home_main_product %}
					{# Video thumb #}
					<div class="swiper-slide product-thumb-container">
						{% include 'snipplets/product/product-video.tpl' with {thumb: true} %}
					</div>
				{% endif %}
			</div>
		</div>
		<div class="js-swiper-product-thumbs-prev swiper-button-prev swiper-button-inline svg-icon-text d-none d-md-inline-block">
			<svg class="icon-inline icon-lg icon-flip-vertical"><use xlink:href="#arrow-long-down"/></svg>
		</div>
		<div class="js-swiper-product-thumbs-next swiper-button-next swiper-button-inline svg-icon-text d-none d-md-inline-block">
			<svg class="icon-inline icon-lg"><use xlink:href="#arrow-long-down"/></svg>
		</div>
	</div>
{% endif %}
