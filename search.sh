#!/usr/bin/env bash
if [[ -n "$1" ]]; then
	curl -G "https://predb.ovh/api/v1/" \
		--silent \
		--data-urlencode "q=$1" | \
		/usr/local/bin/jq '.data .rows | {items: [ .[] | {
			title: .name,
			subtitle: (
				.cat + " | " +
				(if .genre != "" then (.genre + " | " ) else null end) +
				if .size != 0 then (.size | tostring) + "MB | " else null end  +
				(.preAt | strftime("%d.%m.%y | %H:%M"))),
			arg: .name,
			icon: {
				path: (
					if (.cat | test("TV")) then "icons/series.png"
					elif (.cat | test("XXX")) then "icons/xxx.png"
					elif (.cat | test("X26|BLURAY|DVD|XVID")) then "icons/movie.png"
					elif (.cat | test("MP3|FLAC")) then "icons/music.png"
					elif (.cat | test("EBOOK")) then "icons/ebook.png"
					elif (.cat | test("MVID")) then "icons/mvid.png"
					elif (.cat | test("PRE")) then "icons/tutorial.png"
					elif (.cat | test("APP")) then "icons/app.png"
					elif (.cat | test("GAME|NSW")) then "icons/game.png"
					else "icons/unknown.png" end
				) },
			autocomplete: .name,
			text: { copy: .name, largetype: .name },
			quicklookurl: .url
		}]}'
fi