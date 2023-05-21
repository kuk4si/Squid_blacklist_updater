# Документация Squid_blacklist_updater

## Установка:
```python
git clone https://github.com/kuk4si/Squid_blacklist_updater.git
```
___

## Переменные script.sh

Стандартные пути к **wget** и **tar**:
wget=/usr/bin/wget
tar=/usr/bin/tar


```python
- LOCATION :  указывает директирию, где находятся запрещённые списки
(по-умолчанию: /var/squidGuard)
```

```python
- WGET_FILE_OUTPUT_NAME - переименовывает архив после его скачивания
(по-умолчанию: squid_blacklist.tar)
```

```python
- DB_URL - ссылка на черный список.
```

```python
- FILENAME_DURING_UNTARRING - после распаковки архива переименовывает директорию в указанное название
(по-умолчанию: blacklists)
```

```python
- CUSTOM_BLACKLISTS - можно указать путь к директории с дополнительными списками, 
они будут добавляться автоматически каждый раз после переустановки чёрного списка.
ВСЕ файлы из указанной директории будут копироваться в squidGuard/blacklists.
Можно ничего не указывать.
(по-умолчанию: пусто)

```
