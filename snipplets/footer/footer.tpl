<footer class="bg-background-dark text-white pt-16 pb-8 border-t border-white/5">
	<div class="max-w-7xl mx-auto px-4">
		<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 mb-16">
			<div>
				<h2 class="text-2xl font-black tracking-tighter uppercase italic mb-6">
					{% if has_logo %}
						{{ component('logos/logo', {logo_img_classes: 'h-8 w-auto object-contain'}) }}
					{% else %}
						IVANA<span class="text-primary">DESIGN</span>
					{% endif %}
				</h2>
				<p class="text-white/60 text-sm leading-relaxed mb-6">{{ settings.footer_about_description | default('Premium Sportswear para mujeres que buscan rendimiento y estilo en cada movimiento.') }}</p>
				<div class="flex gap-4">
					{% if store.facebook %}<a class="w-8 h-8 rounded-full bg-white/10 flex items-center justify-center hover:bg-primary transition-colors" href="{{ store.facebook }}"><span class="material-symbols-outlined text-sm">share</span></a>{% endif %}
					{% if store.instagram %}<a class="w-8 h-8 rounded-full bg-white/10 flex items-center justify-center hover:bg-primary transition-colors" href="{{ store.instagram }}"><span class="material-symbols-outlined text-sm">photo_camera</span></a>{% endif %}
				</div>
			</div>
			<div>
				<h3 class="font-black uppercase text-xs tracking-widest mb-6 text-primary">{{ 'Categorías' | translate }}</h3>
				<ul class="space-y-4 text-sm text-white/70">
					{% for category in categories %}
						<li><a class="hover:text-white transition-colors" href="{{ category.url }}">{{ category.name }}</a></li>
					{% endfor %}
				</ul>
			</div>
			<div>
				<h3 class="font-black uppercase text-xs tracking-widest mb-6 text-primary">{{ 'Ayuda' | translate }}</h3>
				<ul class="space-y-4 text-sm text-white/70">
					{% for item in footer_menu %}
						<li><a class="hover:text-white transition-colors" href="{{ item.url }}">{{ item.name }}</a></li>
					{% endfor %}
				</ul>
			</div>
			<div>
				<h3 class="font-black uppercase text-xs tracking-widest mb-6 text-primary">Newsletter</h3>
				<p class="text-sm text-white/60 mb-4">{{ settings.news_description | default('Sumate a nuestra comunidad y obtené un 10% OFF en tu primera compra.') }}</p>
				<form action="/newsletter" method="post" class="flex flex-col gap-3">
					<input name="email" class="bg-white/5 border border-white/10 rounded-lg px-4 py-2 text-sm focus:border-primary focus:ring-0" placeholder="Email" type="email"/>
					<button class="bg-primary py-2 rounded-lg font-bold text-sm uppercase tracking-widest hover:brightness-110 transition-all hover:bg-[#d43d1f]">Suscribirme</button>
				</form>
			</div>
		</div>
		<div class="border-t border-white/5 pt-8 flex flex-col md:flex-row justify-between items-center gap-6">
			<p class="text-[10px] text-white/40 uppercase tracking-widest">© {{ "now"|date("Y") }} {{ store.name }}. All Rights Reserved.</p>
			<div class="flex items-center gap-4 opacity-50 grayscale hover:grayscale-0 transition-all">
				{% for payment in payment_methods %}
					{{ payment | payment_logo | img_tag('', {class: 'h-6'}) }}
				{% endfor %}
			</div>
		</div>
	</div>
</footer>