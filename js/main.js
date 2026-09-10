/* ==========================================================================
   ULTIMATE SPIDER-MAN (2012) - Scripts de la pagina de inicio
   ========================================================================== */
(function () {
  'use strict';

  var menosMovimiento = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  /* ------------------------------------------------------------------
     1) IMAGENES: si el archivo local de /img/ todavia no existe,
        se usa la URL de respaldo guardada en data-respaldo.
     ------------------------------------------------------------------ */
  document.querySelectorAll('img[data-respaldo]').forEach(function (img) {
    img.addEventListener('error', function alRomperse() {
      img.removeEventListener('error', alRomperse);
      img.src = img.dataset.respaldo;
    });
    if (img.complete && img.naturalWidth === 0) {
      img.src = img.dataset.respaldo;
    }
  });

  /* ------------------------------------------------------------------
     2) MENU HAMBURGUESA (mobile)
     ------------------------------------------------------------------ */
  var menuBtn = document.getElementById('menuBtn');
  var nav = document.getElementById('navPrincipal');

  if (menuBtn && nav) {
    menuBtn.addEventListener('click', function () {
      var abierto = nav.classList.toggle('abierto');
      menuBtn.setAttribute('aria-expanded', String(abierto));
      menuBtn.setAttribute('aria-label', abierto ? 'Cerrar menu de navegacion' : 'Abrir menu de navegacion');
    });

    nav.querySelectorAll('a').forEach(function (enlace) {
      enlace.addEventListener('click', function () {
        nav.classList.remove('abierto');
        menuBtn.setAttribute('aria-expanded', 'false');
      });
    });
  }

  /* ------------------------------------------------------------------
     3) BOTON "VOLVER ARRIBA"
     ------------------------------------------------------------------ */
  var btnArriba = document.getElementById('btnArriba');

  if (btnArriba) {
    window.addEventListener('scroll', function () {
      btnArriba.classList.toggle('visible', window.scrollY > 500);
    }, { passive: true });
  }

  /* ------------------------------------------------------------------
     4) LOS SPIDER-MAN DEL HERO Y DE "DE QUE VA LA SERIE"
        a) se corren un poco siguiendo el mouse
        b) los que se asoman desde el borde quedan fijos al hacerles clic
     ------------------------------------------------------------------ */
  var puedeMoverse = !menosMovimiento && window.matchMedia('(hover: hover)').matches;

  function seguirElMouse(seccion) {
    if (!seccion || !puedeMoverse) return;
    var suyas = Array.prototype.slice.call(seccion.querySelectorAll('.arana'));
    if (!suyas.length) return;

    var pendiente = false;
    var ultimoX = 0, ultimoY = 0;

    seccion.addEventListener('mousemove', function (e) {
      var caja = seccion.getBoundingClientRect();
      ultimoX = (e.clientX - caja.left) / caja.width - 0.5;
      ultimoY = (e.clientY - caja.top) / caja.height - 0.5;

      if (pendiente) return;
      pendiente = true;

      requestAnimationFrame(function () {
        pendiente = false;
        suyas.forEach(function (arana, i) {
          var fuerza = 12 + (i % 4) * 7;
          arana.style.setProperty('--mx', (ultimoX * fuerza).toFixed(1) + 'px');
          arana.style.setProperty('--my', (ultimoY * fuerza * 0.6).toFixed(1) + 'px');
        });
      });
    });

    seccion.addEventListener('mouseleave', function () {
      suyas.forEach(function (arana) {
        arana.style.setProperty('--mx', '0px');
        arana.style.setProperty('--my', '0px');
      });
    });
  }

  seguirElMouse(document.getElementById('inicio'));
  seguirElMouse(document.getElementById('serie'));

  // Clic: el personaje sale del borde y se planta en su lugar (y vuelve si se repite)
  document.querySelectorAll('.arana--asomada').forEach(function (arana) {
    arana.addEventListener('click', function () {
      var fijada = arana.classList.toggle('fijada');
      arana.setAttribute('aria-pressed', String(fijada));
      arana.setAttribute('title', fijada
        ? 'Clic para que ' + arana.dataset.nombre + ' vuelva a esconderse'
        : 'Clic para que ' + arana.dataset.nombre + ' salga');
    });
    arana.setAttribute('title', 'Clic para que ' + arana.dataset.nombre + ' salga');
    arana.setAttribute('aria-label', arana.dataset.nombre);
  });

  /* ------------------------------------------------------------------
     5) VISOR DE IMAGENES DE LA GALERIA (lightbox)
     ------------------------------------------------------------------ */
  var visor = document.getElementById('visor');
  var visorImg = document.getElementById('visorImg');
  var visorTexto = document.getElementById('visorTexto');
  var visorContador = document.getElementById('visorContador');
  var items = Array.prototype.slice.call(document.querySelectorAll('.galeria__item'));
  var actual = 0;
  var ultimoBoton = null;

  function mostrar(indice) {
    if (!items.length) return;
    actual = (indice + items.length) % items.length;

    var boton = items[actual];
    var img = boton.querySelector('img');

    visorImg.src = img.currentSrc || img.src;
    visorImg.alt = img.alt || '';
    visorTexto.textContent = boton.dataset.texto || img.alt || '';
    visorContador.textContent = (actual + 1) + ' / ' + items.length;
  }

  function abrir(indice, boton) {
    ultimoBoton = boton || null;
    mostrar(indice);
    visor.hidden = false;
    document.body.classList.add('sin-scroll');
    document.getElementById('visorCerrar').focus();
  }

  function cerrar() {
    visor.hidden = true;
    document.body.classList.remove('sin-scroll');
    if (ultimoBoton) ultimoBoton.focus();
  }

  items.forEach(function (boton, i) {
    boton.addEventListener('click', function () { abrir(i, boton); });
  });

  if (visor) {
    document.getElementById('visorCerrar').addEventListener('click', cerrar);
    document.getElementById('visorPrev').addEventListener('click', function () { mostrar(actual - 1); });
    document.getElementById('visorNext').addEventListener('click', function () { mostrar(actual + 1); });

    visor.addEventListener('click', function (e) {
      if (e.target === visor) cerrar();
    });

    document.addEventListener('keydown', function (e) {
      if (visor.hidden) return;
      if (e.key === 'Escape') cerrar();
      if (e.key === 'ArrowLeft') mostrar(actual - 1);
      if (e.key === 'ArrowRight') mostrar(actual + 1);
    });

    var inicioX = null;
    visor.addEventListener('touchstart', function (e) { inicioX = e.changedTouches[0].clientX; }, { passive: true });
    visor.addEventListener('touchend', function (e) {
      if (inicioX === null) return;
      var salto = e.changedTouches[0].clientX - inicioX;
      if (Math.abs(salto) > 50) mostrar(actual + (salto < 0 ? 1 : -1));
      inicioX = null;
    }, { passive: true });
  }

  /* ------------------------------------------------------------------
     6) APARICION SUAVE AL HACER SCROLL
     ------------------------------------------------------------------ */
  var animables = document.querySelectorAll('.tarjeta, .heroe, .temporada, .galeria__item, .dato, .ficha');

  if ('IntersectionObserver' in window && !menosMovimiento) {
    animables.forEach(function (el) {
      el.style.opacity = '0';
      el.style.transform = 'translateY(24px)';
      el.style.transition = 'opacity .5s ease, transform .5s ease';
    });

    var observador = new IntersectionObserver(function (entradas) {
      entradas.forEach(function (entrada, i) {
        if (!entrada.isIntersecting) return;
        var el = entrada.target;
        setTimeout(function () {
          el.style.opacity = '1';
          el.style.transform = 'translateY(0)';
        }, i * 70);
        observador.unobserve(el);
      });
    }, { threshold: 0.15 });

    animables.forEach(function (el) { observador.observe(el); });
  }

  /* ------------------------------------------------------------------
     7) FORMULARIO DE CONTACTO (demo, no envia nada a un servidor)
     ------------------------------------------------------------------ */
  var formulario = document.querySelector('.formulario');

  if (formulario) {
    formulario.addEventListener('submit', function (e) {
      e.preventDefault();
      var boton = formulario.querySelector('button[type="submit"]');
      var textoOriginal = boton.innerHTML;
      boton.innerHTML = '<i class="fa-solid fa-check"></i> Mensaje enviado';
      formulario.reset();
      setTimeout(function () { boton.innerHTML = textoOriginal; }, 2600);
    });
  }

})();
