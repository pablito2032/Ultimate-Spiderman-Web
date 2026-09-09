# ============================================================================
#  Descarga las imagenes del sitio a la carpeta /img/
#  Uso: clic derecho sobre este archivo -> "Ejecutar con PowerShell"
#  (o desde PowerShell:  .\descargar-imagenes.ps1 )
#
#  NOTA: estos archivos YA estan en /img/ y el script NO los toca:
#        Logo_Ultimate-Spiderman.png, logo-chibi.webp,
#        spider-miles.webp, spider-ham.webp y villano-ock.webp
# ============================================================================

$base = "https://static.wikia.nocookie.net/thedailybugle/images/"
$destino = Join-Path $PSScriptRoot "img"

if (-not (Test-Path $destino)) { New-Item -ItemType Directory -Path $destino | Out-Null }

$imagenes = [ordered]@{
  # --- Hero: fondo y los Spider-Man de otros universos ---
  "hero.png"             = "1/1f/SPIDER-MAN%27S_WEB_WARRIORS_USWW.png"
  "spider-noir.png"      = "0/0e/Noir.png"
  "spider-2099.png"      = "c/ce/2099.png"
  "spider-scarlet.png"   = "d/da/USM_Scarlet-Spider.png"
  "spider-caballero.png" = "f/f1/Spyder_Knight.png"
  "spider-iron.png"      = "9/9d/Iron_Spider_Cho.png"

  # --- Equipo (imagen normal + imagen del hover) ---
  "equipo.jpg"        = "d/d7/Promotional_art.jpg"
  "p-spiderman.png"   = "6/6d/S1E15_-_Spider-Man%27s_face_close-up.png"
  "p-spiderman-b.png" = "1/13/S01E15_-_Spider-Man_on_the_window.png"
  "p-nova.png"        = "e/ee/Nova~2.png"
  "p-nova-b.png"      = "e/e3/Spider-Man_and_Ultimate_Nova_1_USWW~2.png"
  "p-tigre.png"       = "e/e7/Profile_-_White_Tiger.png"
  "p-tigre-b.png"     = "2/28/41-1.jpg.png"
  "p-powerman.png"    = "4/4d/Power_Man_USM_001.png"
  "p-powerman-b.png"  = "8/81/20.jpg.png"
  "p-ironfist.png"    = "1/15/Iron_Fist_fights_in_Damage.png"
  "p-ironfist-b.png"  = "5/5b/Iron_Fist_Face.png"
  "p-venom.png"       = "c/cf/Agen_00Venom.png"
  "p-venom-b.png"     = "e/ed/Carnage_Agent_Venom.png"

  # --- Temporadas ---
  "t1.jpg"            = "0/09/Classic_Team.jpg"
  "t2.png"            = "5/5f/SEASON_2_SPIDER_MAN.png"
  "t3.png"            = "7/73/NewWebWarriors.png"
  "t4.png"            = "a/ac/Chonewwaariors.png"

  # --- Galeria ---
  "g1.png"            = "7/7b/S01E15_-_Spider-Man_crawls_on_a_building.png"
  "g2.png"            = "5/54/S01E15_-_Spider-Man_Webslings_Nick_Fury%27s_ship.png"
  "g3.png"            = "a/ab/Spider-Man_and_the_Web_Warriors_USMWW_3.png"
  "g4.png"            = "e/e5/Peter_being_bitten.png"
  "g5.png"            = "6/62/S2E04_-_Spider-Man_bangs_on_Nova%27s_helmet.png"
  "g6.png"            = "0/07/Iron_Spider_Armor.png"
  "g7.jpg"            = "c/c7/Spider-Man_in_Dream_Dimension.jpg"
  "g8.jpg"            = "f/f8/Spider-Man%2C_Iron_Fist_and_Doctor_Strange_in_the_dream_world.jpg"
  "g9.png"            = "1/19/S01E15_-_Um..._Did_I_hop_on_the_wrong_floating_headquarters_of_a_secret_world_peace_keeping_task_force_again%3F.png"
  "g10.jpg"           = "d/d1/Scarlet_Spider_with_Kraven.jpg"
  "g11.png"           = "d/d9/Electro_against_the_Web_Warriors_USMWW.png"
  "g12.jpg"           = "3/33/Web-Warriors.jpg"
  "g13.png"           = "e/e3/Norman_face.png"
  "g14.jpg"           = "2/25/All_Web_Warriors.jpg"
}

Write-Host "Descargando $($imagenes.Count) imagenes en: $destino" -ForegroundColor Cyan

foreach ($nombre in $imagenes.Keys) {
  $url = $base + $imagenes[$nombre]
  $salida = Join-Path $destino $nombre
  try {
    Invoke-WebRequest -Uri $url -OutFile $salida -UseBasicParsing -Headers @{ "User-Agent" = "Mozilla/5.0" }
    Write-Host ("  OK    -> " + $nombre) -ForegroundColor Green
  } catch {
    Write-Host ("  ERROR -> " + $nombre + " : " + $_.Exception.Message) -ForegroundColor Red
  }
}

Write-Host "Listo. Abri index.html en el navegador." -ForegroundColor Cyan
