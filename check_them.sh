#!/bin/bash

                                                              # Визначаємо масив з URL вебсайтів для перевірки
sites=(
  "https://google.com"
  "https://facebook.com"
  "https://twitter.com"
  "https://twitch.tv"
  "https://youtube.com"
)

logfile="website_status.log"                                  # Назва файлу логів

> "$logfile"                                                  # Очищаємо файл логів перед записом нових даних

# Функція для перевірки статусу сайту
check_site() {
  response=$(curl -s --head --location "$1" | grep HTTP/)     # Використовуємо curl для перевірки статусу, з обробкою переадресацій

  if echo "$response" | grep -q "200"; then                   # Перевіряємо, чи статус код 200
    echo "$1 is UP"
    echo "$1 is UP" >> "$logfile"                             # Записуємо статус UP у файл, якщо так
  else
    echo "$1 is DOWN"
    echo "$1 is DOWN" >> "$logfile"                           # Записуємо статус DOWN у файл, якщо інакше
  fi
}

for site in "${sites[@]}"; do                                 # Перебір кожного сайту з масиву та виклик функції check_site
  check_site "$site"
done

echo "Results have been written to $logfile"                  # Виводимо повідомлення про те, що результати записано у файл логів
