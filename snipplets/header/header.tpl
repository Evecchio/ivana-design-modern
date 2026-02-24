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
		<div class="flex-1 max-w-md hidden md:block">
			{{ component('search/search-form', {
				form_classes: { 
					input_group: 'relative m-0', 
					input: 'w-full bg-primary/5 border-none rounded-full py-2 pl-10 pr-4 text-sm focus:ring-2 focus:ring-primary/20', 
					submit: 'material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg', 
					delete_content: 'hidden',  
					search_suggestions_container: 'z-50'
				}
				}) 
			}}
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