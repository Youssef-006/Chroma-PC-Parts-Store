// Sticky nav shadow on scroll
  const navbar = document.getElementById('navbar');
  window.addEventListener('scroll', () => {
    navbar.classList.toggle('scrolled', window.scrollY > 20);
  });

  // Mobile menu toggle
  function toggleMenu() {
    document.getElementById('navLinks').classList.toggle('open');
  }

  // Stagger product card animations on scroll
  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry, i) => {
      if (entry.isIntersecting) {
        entry.target.style.animationDelay = (i * 0.08) + 's';
        entry.target.classList.add('visible');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1 });

  document.querySelectorAll('.cat-card, .why-card').forEach(el => observer.observe(el));
