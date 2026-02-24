{# Account utility #}

{% set account_url = not customer ? store.customer_login_url : store.customer_home_url %}

<div class="relative group">
    <a href="{{ account_url }}" class="flex items-center justify-center w-10 h-10 rounded-full border border-slate-200 dark:border-slate-800 hover:border-primary hover:bg-primary/5 transition-all group-hover:scale-105" title="{{ 'Mi cuenta' | translate }}">
        <span class="material-symbols-outlined text-[22px] text-slate-700 dark:text-slate-200 group-hover:text-primary">person</span>
    </a>
    
    {# Hover dropdown for quick actions #}
    <div class="absolute right-0 top-full mt-2 w-48 bg-white dark:bg-slate-900 rounded-xl shadow-2xl border border-slate-100 dark:border-slate-800 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all z-50 p-2 overflow-hidden">
        {% if not customer %}
            <a href="{{ store.customer_login_url }}" class="block px-4 py-2 text-xs font-black uppercase tracking-widest text-slate-700 dark:text-slate-300 hover:bg-primary hover:text-white rounded-lg transition-colors">
                {{ "Entrar" | translate }}
            </a>
            {% if 'mandatory' not in store.customer_accounts %}
                <a href="{{ store.customer_register_url }}" class="block px-4 py-2 text-xs font-black uppercase tracking-widest text-primary hover:bg-primary/5 rounded-lg transition-colors">
                    {{ "Registrarse" | translate }}
                </a>
            {% endif %}
        {% else %}
            {% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %}
            <div class="px-4 py-2 border-b border-slate-100 dark:border-slate-800 mb-1">
                <span class="text-[10px] font-bold text-slate-400 uppercase tracking-tighter block mb-0.5">{{ "Hola," | translate }}</span>
                <span class="text-sm font-black text-slate-900 dark:text-white truncate block">{{ customer_short_name }}</span>
            </div>
            <a href="{{ store.customer_home_url }}" class="block px-4 py-2 text-xs font-bold text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-800 rounded-lg transition-colors">
                {{ "Mis pedidos" | translate }}
            </a>
            <a href="{{ store.customer_logout_url }}" class="block px-4 py-2 text-xs font-bold text-red-500 hover:bg-red-50 rounded-lg transition-colors">
                {{ "Cerrar sesión" | translate }}
            </a>
        {% endif %}
    </div>
</div>