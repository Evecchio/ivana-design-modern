{% if product_modal %}

	{# Product video modal wrapper #}

	<div id="product-video-modal" class="js-product-video-modal product-video" style="display: none;">
{% endif %}
		<div class="{% if not thumb %}js-video{% endif %} {% if product_video and not product_modal %}js-video-product{% endif %} {% if not thumb %}embed-responsive embed-responsive-16by9{% endif %} visible-when-content-ready position-relative">
			{% if not thumb %}
				{% if product_modal_trigger %}

					{# Open modal in mobile with product video inside #}

					<a href="#product-video-modal" data-fancybox="product-gallery" class="js-play-button video-player d-block d-md-none">
						<div class="video-player-icon">
							<svg class="icon-inline svg-icon-text ml-1"><use xlink:href="#play"/></svg>
						</div>
					</a>
				{% endif %}
				<a href="javascript:void(0)" class="js-play-button video-player {% if product_modal_trigger %}d-none d-md-block{% endif %}">
			{% endif %}
				<div class="video-player-icon{% if thumb %} video-player-icon-small{% endif %}">
					<svg class="icon-inline svg-icon-text {% if thumb %} icon-xs{% endif %} ml-1"><use xlink:href="#play"/></svg>
				</div>
			{% if not thumb %}
				</a>
			{% endif %}

			{# Video thumbnail #}
			
			<div class="js-video-image">
				<img src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" data-src="" class="lazyload {% if thumb %}video-image-thumb{% else %}img-fluid{% endif %} fade-in" alt="{{ 'Video de' | translate }} {% if template == 'product' %}{{ product.name }}{% else %}{{ store.name }}{% endif %}" style="display: none;">
				<div class="placeholder-fade"></div>
			</div>
		</div>

		{% if not thumb %}

			{# Empty iframe component: will be filled with JS on play button click #}

			{% if product.video_url %}
				{% set video_url = product.video_url %}
			{% endif %}

			<div class="js-video-iframe embed-responsive embed-responsive-16by9" style="display: none;" data-video-color="{{ settings.accent_color | trim('#') }}" data-video-url="{{ video_url }}">
			</div>
		{% endif %}
{% if product_modal %}
	</div>
{% endif %}
