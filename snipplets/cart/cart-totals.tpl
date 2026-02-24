{# Cart totals refined with premium Tailwind styling #}

{# Cart subtotal #}
{% if cart_subtotal %}
  <div class="js-visible-on-cart-filled py-4 border-b border-white/10" {% if cart.items_count == 0 %}style="display:none;"{% endif %} data-store="cart-subtotal">
    <div class="flex items-center justify-between gap-4">
      <span class="text-xs font-black uppercase tracking-widest opacity-60">
        {{ "Subtotal" | translate }}
        <span class="js-subtotal-shipping-wording lowercase font-bold" {% if not (cart.has_shippable_products or show_calculator_on_cart) %}style="display: none"{% endif %}>{{ " (sin envío)" | translate }}</span>
      </span>
      <span class="js-ajax-cart-total js-cart-subtotal text-base font-black italic tracking-tighter" data-priceraw="{{ cart.subtotal }}" data-component="cart.subtotal">{{ cart.subtotal | money }}</span>
    </div>
  </div>
{% endif %}

{# Cart promotions #}
{% if cart_promotions %}
  <div class="js-total-promotions py-4 border-b border-white/10 text-primary-light">
    {% for promotion in cart.promotional_discount.promotions_applied %}
      <div class="flex items-center justify-between gap-4 mb-2 last:mb-0">
        <span class="text-[10px] font-black uppercase tracking-widest text-primary-light flex items-center gap-1">
          <span class="material-symbols-outlined text-sm">label</span>
          {{ promotion.scope_value_name ?: ("todos los productos" | translate) }}
        </span>
        <span class="text-sm font-black italic tracking-tighter">-{{ promotion.total_discount_amount_short }}</span>
      </div>
    {% endfor %}
  </div>
{% endif %}

{# Cart shipping costs #}
{% set show_cart_fulfillment = settings.shipping_calculator_cart_page and (store.has_shipping or store.branches) %}
{% if cart_shipping_costs and show_cart_fulfillment %}
  <div id="shipping-cost-container" class="js-fulfillment-info js-visible-on-cart-filled py-4 border-b border-white/10" {% if cart.items_count == 0 or (not cart.has_shippable_products) %}style="display:none;"{% endif %}>
    <div class="flex items-center justify-between gap-4">
      <span class="text-xs font-black uppercase tracking-widest opacity-60">{{ 'Envío' | translate }}</span>
      <span id="shipping-cost" class="text-xs font-bold italic opacity-40">{{ "Calculalo para verlo" | translate }}</span>
      <span class="js-calculating-shipping-cost text-xs font-bold italic opacity-40" style="display: none">{{ "Calculando" | translate }}...</span>
    </div>    
  </div>
{% endif %}

{# Cart total #}
{% if cart_total %}
  <div class="js-cart-total-container js-visible-on-cart-filled py-8" {% if cart.items_count == 0 %}style="display:none;"{% endif %} data-store="cart-total">
    <div class="flex flex-col items-end gap-1">
      <div class="flex items-center justify-between w-full mb-2">
        <span class="text-lg font-black uppercase italic tracking-tighter">{{ "Total" | translate }}</span>
        <span class="js-cart-total text-3xl font-black italic tracking-tighter text-white" data-component="cart.total" data-component-value={{ cart.total }}>
            {{ cart.total | money }}
        </span>
      </div>
      
      {% set discount_component = component('payment-discount-price', {
          visibility_condition: settings.payment_discount_price,
          location: 'cart',
          container_classes: 'text-[10px] font-black uppercase tracking-widest text-primary-light bg-white/10 px-2 py-1 rounded inline-block',
      }) %}
      {{ discount_component }}

      {% if not settings.payment_discount_price %}
        {{ component('installments', {
            location: 'cart', 
            short_wording: true, 
            container_classes: { installment: "text-[10px] font-bold opacity-60 uppercase tracking-widest" }
        }) }}
      {% endif %}
    </div>
  </div>
{% endif %}
