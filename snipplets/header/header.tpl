<header class="sticky top-0 z-50 w-full bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-md border-b border-primary/10">
	<div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between gap-4">
		<div class="flex items-center gap-2">
			<a href="{{ store.url }}" title="{{ store.name }}">
				{% if has_logo %}
					{{ component('logos/logo', {logo_img_classes: 'h-10 w-auto object-contain'}) }}
				{% else %}
					<div class="flex items-center gap-2">
						<span class="material-symbols-outlined text-primary text-4xl">fitness_center</span>
						<h1 class="text-2xl font-black tracking-tighter uppercase italic">IVANA<span class="text-primary">DESIGN</span></h1>
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
		<div class="flex items-center gap-3">
			{% include "snipplets/header/utilities/account.tpl" %}
			{% include "snipplets/header/utilities/cart.tpl" %}
			<button class="lg:hidden p-2 js-toggle-menu">
				<span class="material-symbols-outlined">menu</span>
			</button>
		</div>
	</div>
</header>
{% include "snipplets/header/header-modals.tpl" %}