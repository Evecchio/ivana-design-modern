{# Cart utility #}

<div id="ajax-cart" data-component='cart-button' class="relative">
	<a href="{{ store.cart_url }}" class="flex items-center justify-center w-10 h-10 rounded-full border border-slate-200 dark:border-slate-800 hover:border-primary hover:bg-primary/5 transition-all hover:scale-105 group" title="{{ 'Carrito' | translate }}">
		<div class="relative">
			<span class="material-symbols-outlined text-[22px] text-slate-700 dark:text-slate-200 group-hover:text-primary">shopping_bag</span>
			<span class="js-cart-widget-amount absolute -top-1.5 -right-1.5 min-w-[18px] h-[18px] bg-primary text-white text-[10px] font-black rounded-full flex items-center justify-center px-1 border-2 border-white dark:border-slate-900 shadow-sm animate-in zoom-in duration-300">
				{{ cart.items_count }}
			</span>
		</div>
	</a>
    
    {# Optional: Tiny hover indicator of total money #}
    <div class="absolute right-0 top-full mt-2 bg-slate-900 text-white text-[9px] font-black uppercase tracking-widest px-2 py-1 rounded opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all whitespace-nowrap z-50">
        {{ 'Total:' | translate }} {{ cart.total | money }}
    </div>
</div>