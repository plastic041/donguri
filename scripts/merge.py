def merge_font(source: str, target: str, term: bool):
  with open(source) as f:
    orig = f.readlines()

  latin = []
    
  if term:
    with open("./temp/donguri16-latin-term.bdf") as f:
      latin = f.readlines()
  else:
    with open("./temp/donguri16-latin.bdf") as f:
      latin = f.readlines()

  orig_properties = [line.strip() for line in orig[:16]]

  orig_chars = [line.strip() for line in orig[17:-1]]
  latin_chars = [line.strip() for line in latin[17:]]

  orig_chars_line = orig[16].strip()
  orig_chars_count = int(orig_chars_line.split(" ")[1])

  latin_chars_line = latin[16].strip()
  latin_chars_count = int(latin_chars_line.split(" ")[1])

  orig_properties.append(f"CHARS {orig_chars_count + latin_chars_count}")

  if term:
    family_name = orig_properties[5]
    family_name = f"{family_name[:-1]} Term\""
    orig_properties[5] = family_name

  orig_chars.extend(latin_chars)

  orig_properties.extend(orig_chars)

  with open(f"./temp/{target}", "+w") as f:
    f.write("\n".join(orig_properties))
    
merge_font("./temp/donguri16-slim-base.bdf", "donguri16-slim-base-with-latin-term.bdf", term=True)
merge_font("./temp/donguri16-base.bdf", "donguri16-base-with-latin-term.bdf", term=True)

merge_font("./temp/donguri16-slim-base.bdf", "donguri16-slim-base-with-latin.bdf", term=False)
merge_font("./temp/donguri16-base.bdf", "donguri16-base-with-latin.bdf", term=False)