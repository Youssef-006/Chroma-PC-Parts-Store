let currentFilter = 'all';

  function filterProducts(category, btn) {
    currentFilter = category;
    if (btn) {
      document.querySelectorAll('.filter-chip').forEach(c => c.classList.remove('active'));
      btn.classList.add('active');
    }
    applyFilters();
  }

  function applyFilters() {
    const query = document.getElementById('searchInput').value.toLowerCase();
    const cards = document.querySelectorAll('.product-card');
    let visible = 0;

    cards.forEach(card => {
      const cat  = (card.dataset.category || '').toLowerCase();
      const name = (card.dataset.name || '').toLowerCase();
      const matchCat    = currentFilter === 'all' || cat === currentFilter.toLowerCase();
      const matchSearch = name.includes(query) || cat.includes(query);

      if (matchCat && matchSearch) {
        card.style.display = '';
        visible++;
      } else {
        card.style.display = 'none';
      }
    });

    document.getElementById('resultsCount').textContent =
            visible === 1 ? '1 product' : visible + ' products';

    document.getElementById('emptyState').classList.toggle('visible', visible === 0);
  }

  function addToCart(productId, btn) {
    fetch(`/cart/add/${productId}`, { method: 'POST' })
      .then(res => {
        if (res.ok) {
          const badge = document.getElementById('cart-count');
          badge.textContent = parseInt(badge.textContent) + 1;
          showToast('Added to cart — <a href="/cart" style="color:#fff;text-decoration:underline;">View Cart →</a>');
        } else {
          showToast('Could not add item');
        }
      })
      .catch(() => {
        const badge = document.getElementById('cart-count');
        badge.textContent = parseInt(badge.textContent) + 1;
        showToast('Added to cart');
      });
  }

  function showToast(msg) {
    const t = document.getElementById('toast');
    t.innerHTML = msg;
    t.classList.add('show');
    setTimeout(() => t.classList.remove('show'), 3000);
  }

  window.addEventListener('DOMContentLoaded', () => {
    applyFilters();
    fetch('/cart/count')
      .then(r => r.json())
      .then(count => {
        document.getElementById('cart-count').textContent = count;
      })
      .catch(() => {});
  });
