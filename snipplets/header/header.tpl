<header class="sticky top-0 z-50 w-full bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-md border-b border-primary/10">
	<div class="max-w-7xl mx-auto px-4 h-20 flex items-center justify-between gap-4">
		<div class="flex items-center gap-2">
			<a href="{{ store.url }}" title="{{ store.name }}">
				{% if has_logo %}
					{{ component('logos/logo', {logo_img_classes: 'h-14 w-auto object-contain'}) }}
				{% else %}
					<div class="flex items-center gap-3">
						<span class="material-symbols-outlined text-primary text-5xl">fitness_center</span>
						<h1 class="text-3xl font-black tracking-tighter uppercase italic">IVANA<span class="text-primary">DESIGN</span></h1>
					</div>
				{% endif %}
			</a>
		</div>
		<nav class="hidden lg:flex items-center gap-6">
			{% for item in navigation %}
				<a class="text-sm font-semibold hover:text-primary transition-colors {% if item.current %}text-primary{% endif %}" href="{{ item.url }}">{{ item.name }}</a>
			{% endfor %}
		</nav>
		<div class="flex-1 max-w-lg hidden md:block">
			<form action="{{ store.search_url }}" method="get" class="relative group">
				<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none">
					<span class="material-symbols-outlined text-slate-400 group-focus-within:text-primary transition-colors text-xl">search</span>
				</div>
				<input 
					type="text" 
					name="q" 
					placeholder="{{ '¿Qué estás buscando?' | translate }}" 
					class="w-full bg-slate-100 dark:bg-slate-800/50 border-2 border-transparent py-2.5 pl-11 pr-4 rounded-xl text-sm font-medium focus:bg-white focus:border-primary/30 focus:ring-4 focus:ring-primary/5 transition-all outline-none"
					autocomplete="off"
				/>
			</form>
		</div>
		<div class="flex items-center gap-2">
			<button class="md:hidden p-2 js-toggle-search">
				<span class="material-symbols-outlined">search</span>
			</button>
			{% include "snipplets/header/utilities/account.tpl" %}
			{% include "snipplets/header/utilities/cart.tpl" %}
			<button class="lg:hidden p-2 js-toggle-menu">
				<span class="material-symbols-outlined">menu</span>
			</button>
		</div>
	</div>

	{# Mobile Search - Expanded #}
	<div class="js-mobile-search hidden absolute top-full left-0 w-full bg-white dark:bg-background-dark p-4 border-b border-primary/10 shadow-xl transition-all duration-300 -translate-y-2 opacity-0">
		<form action="{{ store.search_url }}" method="get" class="relative">
			<input 
				type="text" 
				name="q" 
				placeholder="{{ '¿Qué estás buscando?' | translate }}" 
				class="w-full bg-slate-100 dark:bg-slate-800/50 border-2 border-primary/20 py-3 pl-11 pr-4 rounded-xl text-sm font-medium focus:border-primary focus:ring-4 focus:ring-primary/5 transition-all outline-none"
			/>
			<span class="material-symbols-outlined absolute left-3.5 top-1/2 -translate-y-1/2 text-primary text-xl">search</span>
		</form>
	</div>
</header>

<style>
	.js-mobile-search.active { display: block; transform: translateY(0); opacity: 1; }
</style>
{% include "snipplets/header/header-modals.tpl" %}