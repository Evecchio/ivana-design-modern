<div id="shoppingCartPage" data-minimum="{{ settings.cart_minimum_value }}" data-store="cart-page" class="max-w-7xl mx-auto px-4 py-12">
    
    <div class="mb-10 text-center">
        <h1 class="text-4xl font-black uppercase italic tracking-tighter dark:text-white">
            {{ "Tu Carrito" | translate }}
        </h1>
        <div class="w-12 h-1 bg-primary mx-auto mt-4"></div>
    </div>
    
    <form action="{{ store.cart_url }}" method="post" class="visible-when-content-ready" data-store="cart-form" data-component="cart">

        {# Cart alerts #}
        {% if error.add %}
            <div class="mb-6 p-4 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl text-amber-800 dark:text-amber-400 text-sm font-bold">
                {{ 'our_components.cart.error_messages.' ~ error.add | translate }}
            </div>
        {% endif %}

        {% if cart.items %}
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 items-start">
                
                {# Products List #}
                <div class="lg:col-span-8">
                    <div class="js-ajax-cart-list bg-white dark:bg-slate-900/50 p-6 md:p-8 rounded-3xl border border-slate-100 dark:border-slate-800 shadow-sm">
                        {% for item in cart.items %}
                            {% include "snipplets/cart-item-ajax.tpl" with {'cart_page': true} %}
                        {% endfor %}
                    </div>

                    <div class="mt-8 flex items-center justify-between">
                        <a href="{{ store.products_url }}" class="flex items-center gap-2 text-xs font-black uppercase tracking-widest text-slate-400 hover:text-primary transition-colors">
                            <span class="material-symbols-outlined text-base">arrow_back</span>
                            {{ "Seguir comprando" | translate }}
                        </a>
                    </div>
                </div>

                {# Order Summary #}
                <div class="lg:col-span-4 sticky top-24">
                    <div class="bg-slate-900 dark:bg-primary text-white p-8 rounded-3xl shadow-xl shadow-black/10">
                        <h3 class="text-xl font-black uppercase italic tracking-tighter mb-6">{{ "Resumen" | translate }}</h3>
                        
                        {% include "snipplets/cart/cart-summary.tpl" with {cart_page: true} %}
                        
                        {# Custom Promo Box in Summary #}
                        <div class="mt-6 pt-6 border-t border-white/10">
                            <div class="flex items-center gap-2 text-primary dark:text-white font-black uppercase tracking-tighter text-[10px]">
                                <span class="material-symbols-outlined text-sm">local_shipping</span>
                                {{ "Envío gratis superando el mínimo" | translate }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        {% else %}
            {# Empty cart #}
            <div class="text-center py-20 bg-slate-50 dark:bg-slate-900/50 rounded-3xl border-2 border-dashed border-slate-200 dark:border-slate-800">
                <span class="material-symbols-outlined text-6xl text-slate-200 dark:text-slate-800 mb-4 block">shopping_cart_off</span>
                <p class="text-slate-500 dark:text-slate-400 font-bold mb-8 italic">{{ 'El carrito de compras está vacío.' | translate }}</p>
                <a href="{{ store.products_url }}" class="bg-primary text-white font-black px-10 py-4 rounded-full uppercase tracking-widest text-xs hover:brightness-110 transition-all shadow-xl shadow-primary/20 inline-block font-bold">
                    {{ "Ver productos" | translate }}
                </a>
            </div>
        {% endif %}
    </form>
</div>

