def get_merged_lines(source: list[str], target: list[str]) -> list[str]:
    source_properties = [line.strip() for line in source[:16]]

    source_chars = [line.strip() for line in source[17:-1]]
    target_chars = [line.strip() for line in target[17:]]

    source_chars_line = source[16].strip()
    source_chars_count = int(source_chars_line.split(" ")[1])

    source_chars_line = target[16].strip()
    target_chars_count = int(source_chars_line.split(" ")[1])

    source_properties.append(f"CHARS {source_chars_count + target_chars_count}")

    source_chars.extend(target_chars)

    source_properties.extend(source_chars)

    return source_properties


def merge_latin(source: str, destination: str, term: bool):
    with open(source) as f:
        source_lines = f.readlines()

    latin = []

    if term:
        with open("./temp/donguri16-latin-term.bdf") as f:
            latin = f.readlines()
    else:
        with open("./temp/donguri16-latin.bdf") as f:
            latin = f.readlines()

    merged = get_merged_lines(
        source_lines,
        latin,
    )

    if term:
        family_name = merged[5]
        family_name = f'{family_name[:-1]} Term"'
        merged[5] = family_name

    with open(f"./temp/{destination}", "+w") as f:
        f.write("\n".join(merged))


def merge_jp(source: str, destination: str):
    with open(source) as f:
        source_lines = f.readlines()

    with open("./temp/kh_akihabara.bdf") as f:
        jp_lines = f.readlines()

    merged = get_merged_lines(
        source_lines,
        jp_lines,
    )

    family_name = merged[5]
    family_name = f'{family_name[:-1]} J"'
    merged[5] = family_name

    with open(f"./temp/{destination}", "+w") as f:
        f.write("\n".join(merged))


merge_latin(
    "./temp/donguri16-slim-base.bdf",
    "donguri16-slim-base-with-latin-term.bdf",
    term=True,
)
merge_latin(
    "./temp/donguri16-base.bdf", "donguri16-base-with-latin-term.bdf", term=True
)

merge_latin(
    "./temp/donguri16-slim-base.bdf", "donguri16-slim-base-with-latin.bdf", term=False
)
merge_latin("./temp/donguri16-base.bdf", "donguri16-base-with-latin.bdf", term=False)

merge_jp(
    "./temp/donguri16-slim-base-with-latin.bdf",
    "donguri16-slim-base-with-latin-jp.bdf",
)
merge_jp(
    "./temp/donguri16-base-with-latin.bdf",
    "donguri16-base-with-latin-jp.bdf",
)
