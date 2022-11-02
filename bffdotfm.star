load("render.star", "render")
load("http.star", "http")

BFF_NOWPLAYING = "https://bff.fm/api/data/onair/now.json"

def main():

  resp = http.get(BFF_NOWPLAYING)

  if resp.status_code != 200:
    fail("BFF.fm Now Playing API returned an error (HTTP Status %d)", resp.status_code)

  now_playing = resp.json()

  show = now_playing["program"]
  logo_url = now_playing["program_image"]
  logo = http.get(logo_url).body()


  return render.Root(
    child = render.Row(
      expanded=True, # Use as much horizontal space as possible
      main_align="space_evenly", # Controls horizontal alignment
      cross_align="center",
      children = [
        render.Image(width=32, height=32, src=logo),
        render.Text(show)
      ]
    )
  )
