{# Cart button snippet refined with premium Tailwind styling #}

<div class="js-visible-on-cart-filled mt-8" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>

  {% set cart_total_min = (settings.cart_minimum_value * 100) %}

  {% if cart_page %}
    {# Cart page CTA #}
    {% if cart.checkout_enabled %}
      <input id="go-to-checkout" 
             class="w-full bg-white text-slate-900 font-black py-4 rounded-full uppercase tracking-widest text-sm hover:bg-slate-100 transition-all shadow-xl shadow-black/20 cursor-pointer" 
             type="submit" name="go_to_checkout" value="{{ 'Iniciar compra' | translate }}"/>
    {% else %}
      {# Minimum purchase alert #}
      <div class="p-4 bg-red-500/20 border border-red-500/30 rounded-2xl mb-4">
        <p class="text-[10px] font-black uppercase tracking-widest text-red-200 text-center">
            {{ "El monto mínimo de compra es de {1} sin incluir el costo de envío" | t(cart_total_min | money) }}
        </p>
      </div>
      <button class="w-full bg-slate-800 text-slate-500 font-black py-4 rounded-full uppercase tracking-widest text-sm cursor-not-allowed" disabled>
        {{ 'Iniciar compra' | translate }}
      </button>
    {% endif %}

  {% else %}

    {# Cart popup CTA #}
    <div class="js-ajax-cart-submit mb-4" {{ not cart.checkout_enabled ? 'style="display:none"' }} id="ajax-cart-submit-div" >
      <input class="w-full bg-primary text-white font-black py-4 rounded-full uppercase tracking-widest text-xs hover:brightness-110 transition-all shadow-lg shadow-primary/20 cursor-pointer" 
             type="submit" name="go_to_checkout" value="{{ 'Iniciar compra' | translate }}" data-component="cart.checkout-button"/>
    </div>
    
    <div class="js-ajax-cart-minimum p-3 bg-amber-500/10 border border-amber-500/20 rounded-xl mb-4" {{ cart.checkout_enabled ? 'style="display:none"' }} id="ajax-cart-minumum-div">
      <p class="text-[10px] font-bold uppercase tracking-widest text-amber-600 dark:text-amber-400 text-center leading-tight">
        {{ "El monto mínimo de compra es de {1} sin incluir el costo de envío" | t(cart_total_min | money) }}
      </p>
    </div>

    <input type="hidden" id="ajax-cart-minimum-value" value="{{ cart_total_min }}"/>
  {% endif %}

  {# Continue Buying Link (only if not cart page, since cart page already has it) #}
  {% if not cart_page %}
    <div class="text-center mt-4">
      <a href="{{ store.products_url }}" class="js-modal-close-private text-[10px] font-black uppercase tracking-[0.2em] text-slate-400 hover:text-primary transition-colors">
        {{ 'Continuar comprando' | translate }}
      </a>
    </div>
  {% endif %}
</div>