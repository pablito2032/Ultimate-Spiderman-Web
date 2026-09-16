# ============================================================================
#  Descarga las imagenes de los episodios (por temporada) a /img/
#  Uso: clic derecho sobre este archivo -> "Ejecutar con PowerShell"
#  (o desde PowerShell:  .\descargar-imagenes-temporadas.ps1 )
#
#  Las imagenes vienen del wiki de fans "The Daily Bugle" (fandom.com), igual
#  que el resto de las imagenes del sitio. El wiki las sirve convertidas a
#  webp aunque el nombre de archivo original diga .png o .jpg, por eso se
#  guardan localmente con extension .webp: es el formato real de los bytes.
# ============================================================================

$destino = Join-Path $PSScriptRoot "img"

if (-not (Test-Path $destino)) { New-Item -ItemType Directory -Path $destino | Out-Null }

$imagenes = [ordered]@{
  # --- Elenco flotante de la temporada 1 (seccion "Episodio por episodio") ---
  # Ninguna de estas se recicla de index.html: son imagenes propias para esta
  # seccion, distintas de las que ya se usan en la home para esos personajes.
  "elenco-spiderman.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/0/06/Spider-Man_face.png"
  "elenco-fury.webp"      = "https://static.wikia.nocookie.net/thedailybugle/images/a/a3/Nicholas_Fury_USM_001.png"
  "elenco-ock.webp"       = "https://static.wikia.nocookie.net/thedailybugle/images/7/7d/Doctor_Octopus.png"
  "elenco-doom.webp"      = "https://static.wikia.nocookie.net/thedailybugle/images/3/3a/Drdoom.png"
  "elenco-venom.webp"     = "https://static.wikia.nocookie.net/thedailybugle/images/8/8a/Venom.png"
  "elenco-ironman.webp"   = "https://static.wikia.nocookie.net/thedailybugle/images/6/6e/Iron_Man_Mark_L_2.png"
  "elenco-coulson.webp"   = "https://static.wikia.nocookie.net/thedailybugle/images/7/7d/Phil_Coulson_USM_02.jpg"
  "elenco-thor.webp"      = "https://static.wikia.nocookie.net/thedailybugle/images/e/e2/Thor_SHS.png"
  "elenco-beetle.webp"    = "https://static.wikia.nocookie.net/thedailybugle/images/5/5d/Beetle_hy.png"
  "elenco-hulk-panel.webp"= "https://static.wikia.nocookie.net/thedailybugle/images/b/bd/Hulk_Guy.jpg"
  "elenco-goblin.webp"    = "https://static.wikia.nocookie.net/thedailybugle/images/4/4c/The_Goblin_Art.png"

  # --- Temporada 1 (26 episodios) ---
  "t1-ep01.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/e/e3/Https---pbs.twimg.com-media-Gm7QeBIbsAAOkEg%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327191343"
  "t1-ep02.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/0/03/Https---pbs.twimg.com-media-Gm7QiGAbYAIZyr6%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327191606"
  "t1-ep03.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/0/03/Https---pbs.twimg.com-media-Gm7QnB0bMAA0FyG%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327191812"
  "t1-ep04.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/3/33/Https---pbs.twimg.com-media-Gm7QrwHbYAYHJvQ%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327192006"
  "t1-ep05.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/b/b2/Https---pbs.twimg.com-media-Gm7QxeWbYAEFObm%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327192221"
  "t1-ep06.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/4/4b/Https---pbs.twimg.com-media-Gm7Q2FSbYAIQIsC%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327192407"
  "t1-ep07.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/5/59/Https---pbs.twimg.com-media-Gm7Q6MVbcAAyMx_%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327192701"
  "t1-ep08.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/9/99/Https---pbs.twimg.com-media-Gm7RAQ9bYAAXU2A%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327193806"
  "t1-ep09.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/2/27/Https---pbs.twimg.com-media-Gm7RFrQbYAID6-l%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327194011"
  "t1-ep10.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/c/c6/Https---pbs.twimg.com-media-Gm7RKb2bYAQUucK%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327194448"
  "t1-ep11.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/f/fb/Https---pbs.twimg.com-media-Gm7RP_fbYAACnok%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327205212"
  "t1-ep12.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/b/b4/Https---pbs.twimg.com-media-Gm7RV3rbYAIEGzo%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327205400"
  "t1-ep13.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/b/bd/Https---pbs.twimg.com-media-Gm7RaIabYAIKB5M%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327205601"
  "t1-ep14.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/e/e7/Https---pbs.twimg.com-media-Gm8L27oaAAAkVN4%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327205817"
  "t1-ep15.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/5/54/Https---pbs.twimg.com-media-Gm8L7h-aUAAG6Cs%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327210021"
  "t1-ep16.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/2/2f/Https---pbs.twimg.com-media-Gm8MAlubYAIytrq%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327210247"
  "t1-ep17.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/f/f5/Https---pbs.twimg.com-media-Gm8MGjjbYAIaD8K%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327210521"
  "t1-ep18.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/4/46/Https---pbs.twimg.com-media-Gm8MLMlbYAU_tEW%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327210706"
  "t1-ep19.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/8/8a/Https---pbs.twimg.com-media-Gm8MR8SbYAYK2hL%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327210913"
  "t1-ep20.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/2/28/Https---pbs.twimg.com-media-Gm8MWdmbwAAamnb%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327211049"
  "t1-ep21.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/f/f8/Https---pbs.twimg.com-media-Gm8McHrbYAAkwSq%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327211218"
  "t1-ep22.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/c/cf/Https---pbs.twimg.com-media-Gm8MjqHbYAM7eI1%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250327211448"
  "t1-ep23.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/1/1f/Https---cdni.fancaps.net-file-fancaps-tvimages-882575.jpg.png/revision/latest?cb=20250905235859"
  "t1-ep24.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/6/6d/Https---pbs.twimg.com-media-Gm8MzzMbYAER7uW%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250328024715"
  "t1-ep25.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/8/88/Https---pbs.twimg.com-media-Gm8M4IobYAASfqN%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250328024901"
  "t1-ep26.webp" = "https://static.wikia.nocookie.net/thedailybugle/images/c/c5/Https---pbs.twimg.com-media-Gm8M85MbYAAOO9R%3Fformat%3Djpg%26name%3Dlarge.png/revision/latest?cb=20250328025057"
}

Write-Host "Descargando $($imagenes.Count) imagenes en: $destino" -ForegroundColor Cyan

foreach ($nombre in $imagenes.Keys) {
  $url = $imagenes[$nombre]
  $salida = Join-Path $destino $nombre
  try {
    Invoke-WebRequest -Uri $url -OutFile $salida -UseBasicParsing -Headers @{ "User-Agent" = "Mozilla/5.0" }
    Write-Host ("  OK    -> " + $nombre) -ForegroundColor Green
  } catch {
    Write-Host ("  ERROR -> " + $nombre + " : " + $_.Exception.Message) -ForegroundColor Red
  }
}

Write-Host "Listo. Abri temporada-1.html en el navegador." -ForegroundColor Cyan
