// Collect cart totals from rendered rows
  function recalculate() {
    let subtotal = 0;
    document.querySelectorAll('.cart-row').forEach(row => {
      const price = parseFloat(row.dataset.price || 0);
      const qty   = parseInt(row.querySelector('.qty-val')?.textContent || 0);
      const lineTotal = row.querySelector('.total');
      if (lineTotal) lineTotal.textContent = (price * qty).toFixed(2);
      subtotal += price * qty;
    });

    document.getElementById('subtotal').textContent = 'EGP ' + subtotal.toFixed(2);
    document.getElementById('total').textContent    = 'EGP ' + (subtotal * (1 - discount)).toFixed(2);
  }

  let discount = 0;

  function changeQty(productId, delta, btn) {
    const row    = btn.closest('.cart-row');
    const qtyEl  = row.querySelector('.qty-val');
    let qty      = parseInt(qtyEl.textContent) + delta;

    if (qty < 1) { removeItem(productId, btn); return; }

    qtyEl.textContent = qty;

    fetch(`/cart/update/${productId}?quantity=${qty}`, { method: 'POST' })
            .catch(() => {}); // best-effort; recalculate locally anyway

    recalculate();
  }

  function removeItem(productId, btn) {
    const row = btn.closest('.cart-row');
    row.style.opacity = '0';
    row.style.transition = 'opacity 0.3s';
    setTimeout(() => {
      row.remove();
      recalculate();

      // Show empty state if needed
      if (document.querySelectorAll('.cart-row').length === 0) {
        document.querySelector('.cart-items').innerHTML = `
          <div class="cart-section-label">Items</div>
          <div class="empty-cart">
            <p>Your cart is empty.</p>
            <small>Add some pieces to get started</small>
            <a href="/product" class="btn-browse">Browse Collection →</a>
          </div>`;
      }
    }, 300);

    fetch(`/cart/remove/${productId}`, { method: 'DELETE' }).catch(() => {});
  }

  function applyPromo() {
    const code = document.getElementById('promoInput').value.trim().toUpperCase();
    if (code === 'CHROMA10') {
      discount = 0.10;
      document.getElementById('discount').textContent = '−10%';
    } else {
      discount = 0;
      document.getElementById('discount').textContent = '—';
    }
    recalculate();
  }

  function checkout() {
    window.location.href = '/checkout';
  }

  // Init totals on load
  window.addEventListener('DOMContentLoaded', () => {
    recalculate();
    fetch('/cart/count')
      .then(r => r.json())
      .then(count => {
        document.getElementById('cart-count').textContent = count;
      })
      .catch(() => {});
  });
