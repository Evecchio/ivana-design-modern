{# SEO - Invisible to design #}
<h1 class="visually-hidden" style="display: none !important; position: absolute; height: 0; width: 0; overflow: hidden;">{{ store.name }} - {{ 'Tienda de indumentaria' | translate }}</h1>

<main>
	{# Categories Section #}
	<section class="py-8 bg-white dark:bg-slate-900/20 overflow-x-auto no-scrollbar border-b border-slate-100 dark:border-slate-800">
		<div class="max-w-7xl mx-auto px-4 flex justify-between md:justify-center gap-8 min-w-max">
			{% for category in categories %}
				{% set category_image = category.images is not empty ? category.images | first | category_image_url('medium') : (category.products is not empty ? category.products | first.featured_image | product_image_url('medium') : '') %}
				<a href="{{ category.url }}" class="flex flex-col items-center gap-2 group cursor-pointer w-20 flex-shrink-0">
					<div class="w-16 h-16 rounded-full overflow-hidden border-2 border-slate-100 dark:border-slate-800 group-hover:border-primary/50 p-0.5 transition-transform group-hover:scale-105 bg-slate-50 dark:bg-slate-900 flex items-center justify-center shadow-sm">
						{% if category_image %}
							<img class="w-full h-full object-cover rounded-full" src="{{ category_image }}" alt="{{ category.name }}"/>
						{% else %}
							<span class="material-symbols-outlined text-3xl text-slate-300">category</span>
						{% endif %}
					</div>
					<span class="text-[10px] font-black uppercase tracking-tighter text-center text-balance leading-tight dark:text-slate-300 w-full px-1">{{ category.name }}</span>
				</a>
			{% endfor %}
		</div>
	</section>

	{# Super Discounts / Featured Products #}
	<section class="max-w-7xl mx-auto px-4 py-12">
		<div class="flex items-end justify-between mb-8">
			<div>
				<h2 class="text-3xl font-black uppercase italic tracking-tighter text-balance">{{ 'Super Descuentos' | translate }}</h2>
				<p class="text-slate-500 dark:text-slate-400 font-medium text-pretty">{{ 'Nuestras mejores ofertas por tiempo limitado' | translate }}</p>
			</div>
			<a class="text-primary font-bold flex items-center gap-1 group" href="{{ store.products_url }}">
				{{ 'Ver todos' | translate }} <span class="material-symbols-outlined group-hover:translate-x-1 transition-transform">chevron_right</span>
			</a>
		</div>
		<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
			{% for product in sections.primary.products | take(4) %}
				{% include 'snipplets/product-item.tpl' %}
			{% endfor %}
		</div>
	</section>

	{# Sizes Section #}
	<section class="bg-background-dark py-16">
		<div class="max-w-7xl mx-auto px-4">
			<div class="flex flex-col items-center text-center mb-10">
				<h2 class="text-white text-2xl font-black uppercase tracking-widest mb-4 text-balance">{{ 'Encontrá tu talle ideal' | translate }}</h2>
				<div class="w-20 h-1 bg-primary"></div>
			</div>
			<div class="grid grid-cols-2 md:grid-cols-4 gap-4 max-w-2xl mx-auto">
				{% for size in ['XS', 'S', 'M', 'L'] %}
					<button class="border border-white/20 hover:border-primary hover:text-primary py-6 text-xl font-bold text-white transition-all rounded-lg group">
						{{ size }}
					</button>
				{% endfor %}
			</div>
		</div>
	</section>

	{# Manifesto Section #}
	<section class="py-20 bg-primary/5">
		<div class="max-w-4xl mx-auto px-4 text-center">
			<span class="text-primary font-black uppercase tracking-tighter text-sm mb-4 block">Manifesto</span>
			<h2 class="text-4xl md:text-5xl font-black uppercase italic tracking-tighter mb-8 dark:text-white text-balance">{{ 'Somos Ivana Design' | translate }}</h2>
			<p class="text-lg md:text-xl text-slate-600 dark:text-slate-400 leading-relaxed font-medium text-pretty max-w-prose mx-auto">
				Diseñamos para la mujer que no se detiene. Nuestra misión es fusionar la máxima tecnología en tejidos deportivos con un diseño vanguardista y elegante. Ivana Design no es solo ropa, es el empoderamiento que sentís cuando cruzás la meta, terminás tu rutina o simplemente conquistás tu día.
			</p>
			<div class="mt-12">
				<a href="/nosotros" class="bg-primary text-white font-black px-10 py-4 rounded-full uppercase tracking-widest text-sm hover:brightness-110 transition-all shadow-xl shadow-primary/20 inline-block">
					{{ 'Conocé nuestra historia' | translate }}
				</a>
			</div>
		</div>
	</section>
</main>