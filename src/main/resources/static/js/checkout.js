// ── Calculate totals from rendered order rows ──
    function recalculate() {
        let subtotal = 0;
        document.querySelectorAll('.order-item[data-price]').forEach(item => {
            const price = parseFloat(item.dataset.price || 0);
            const qty   = parseInt(item.dataset.qty || 1);
            subtotal += price * qty;
        });
        document.getElementById('subtotal').textContent = 'EGP ' + subtotal.toFixed(2);
        document.getElementById('total').textContent    = 'EGP ' + subtotal.toFixed(2);
    }

    // ── Toggle "Leave at Door" ──
    function toggleLeaveAtDoor() {
        const el  = document.getElementById('leaveAtDoor');
        const inp = document.getElementById('leaveAtDoorVal');
        const on  = el.classList.toggle('active');
        inp.value = on ? 'true' : 'false';
    }

    // ── Payment method selection ──
    function selectPayment(method) {
        document.getElementById('payCard').classList.toggle('selected', method === 'card');
        document.getElementById('payCash').classList.toggle('selected', method === 'cash');
        document.getElementById('paymentMethod').value = method;
    }

    // ── Field validation ──────────────────────────────────────────────────────
    function showError(id, message) {
        const el  = document.getElementById(id);
        el.style.borderColor = 'var(--accent)';
        let errEl = document.getElementById(id + '-error');
        if (!errEl) {
            errEl = document.createElement('div');
            errEl.id = id + '-error';
            errEl.style.cssText = 'color:var(--accent);font-size:0.62rem;margin-top:0.3rem;letter-spacing:0.05em;';
            el.parentNode.insertBefore(errEl, el.nextSibling);
        }
        errEl.textContent = message;
        el.addEventListener('input', () => {
            el.style.borderColor = '';
            if (errEl) errEl.textContent = '';
        }, { once: true });
    }

    function clearErrors() {
        document.querySelectorAll('[id$="-error"]').forEach(el => el.textContent = '');
        document.querySelectorAll('.field-input').forEach(el => el.style.borderColor = '');
    }

    function validate() {
        clearErrors();
        let valid = true;

        const address = document.getElementById('address').value.trim();
        if (!address) { showError('address', 'Street address is required'); valid = false; }

        const city = document.getElementById('city').value.trim();
        if (!city) { showError('city', 'City is required'); valid = false; }

        const governorate = document.getElementById('governorate').value.trim();
        if (!governorate) { showError('governorate', 'Governorate is required'); valid = false; }

        const phone = document.getElementById('phone').value.trim();
        if (!phone) {
            showError('phone', 'Phone number is required'); valid = false;
        } else if (!/^[0-9+\-\s()]{7,20}$/.test(phone)) {
            showError('phone', 'Enter a valid phone number'); valid = false;
        }

        const payment = document.getElementById('paymentMethod').value;
        if (!payment) {
            // highlight both payment cards
            document.getElementById('payCard').style.borderColor = 'var(--accent)';
            document.getElementById('payCash').style.borderColor = 'var(--accent)';
            valid = false;
        }

        if (!valid) {
            // Scroll to the first error
            const firstErr = document.querySelector('.field-input[style*="accent"]');
            if (firstErr) firstErr.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
        return valid;
    }

    // ── Confetti burst ──
    function burst() {
        const colors = ['#c0392b', '#0e0e0e', '#888070', '#d4cfc6', '#f5f2ec'];
        const card   = document.getElementById('successCard');
        for (let i = 0; i < 18; i++) {
            const dot = document.createElement('div');
            dot.className = 'confetti-dot';
            dot.style.cssText = `
        left: ${Math.random() * 100}%;
        top: ${Math.random() * 40}%;
        background: ${colors[Math.floor(Math.random() * colors.length)]};
        animation-delay: ${Math.random() * 0.4}s;
        animation-duration: ${0.9 + Math.random() * 0.6}s;
      `;
            card.appendChild(dot);
            setTimeout(() => dot.remove(), 1800);
        }
    }

    // ── Place order ───────────────────────────────────────────────────────────
    async function placeOrder() {
        if (!validate()) return;

        const btn     = document.getElementById('payBtn');
        const btnText = document.getElementById('payBtnText');
        btn.disabled  = true;
        btnText.textContent = 'Processing...';

        const payload = {
            address:       document.getElementById('address').value.trim(),
            apt:           document.getElementById('apt').value.trim(),
            city:          document.getElementById('city').value.trim(),
            governorate:   document.getElementById('governorate').value.trim(),
            phone:         document.getElementById('phone').value.trim(),
            leaveAtDoor:   document.getElementById('leaveAtDoorVal').value === 'true',
            paymentMethod: document.getElementById('paymentMethod').value
        };

        try {
            const res  = await fetch('/checkout/place-order', {
                method:  'POST',
                headers: { 'Content-Type': 'application/json' },
                body:    JSON.stringify(payload)
            });
            const data = await res.json();

            if (res.ok && data.success) {
                document.getElementById('confirmEmail').textContent = data.email || '';
                const overlay = document.getElementById('successOverlay');
                overlay.classList.add('show');
                setTimeout(burst, 200);
            } else if (data.fieldErrors) {
                // Server returned field-level validation errors
                Object.entries(data.fieldErrors).forEach(([field, msg]) => {
                    const el = document.getElementById(field);
                    if (el) showError(field, msg);
                });
                btn.disabled = false;
                btnText.textContent = 'Place Order →';
            } else {
                alert(data.message || 'Something went wrong. Please try again.');
                btn.disabled = false;
                btnText.textContent = 'Place Order →';
            }
        } catch (e) {
            alert('Network error. Please check your connection.');
            btn.disabled = false;
            btnText.textContent = 'Place Order →';
        }
    }

    window.addEventListener('DOMContentLoaded', recalculate);
