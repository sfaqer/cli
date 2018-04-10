#Использовать logos

Перем Опция Экспорт; // ПараметрКоманды - Ссылка на класс опции
Перем ОпцииИндекс Экспорт; // Соответствие - Ссылка на текущий индекс опций

Перем Лог;

Процедура ПриСозданииОбъекта(КлассОпции, Индекс)
	
	Лог.Отладка("Создан парсер для опции %1", КлассОпции.Имя);
	Опция = КлассОпции;
	ОпцииИндекс = Индекс;

КонецПроцедуры

// Выполняет поиск парсера в массиве входящих аргументов
//
// Параметры:
//   ВходящиеАргументы - массив - входящие аргументы приложения
//   КонтекстПоиска - Объект - класс "КонтекстПарсера"
//
//  Возвращаемое значение:
//   Структура - структура описания токена
//    * РезультатПоиска - булево - признак успешного поиска
//    * Аргументы - Массив - массив оставшихся аргументов после поиска
//
Функция Поиск(Знач ВходящиеАргументы, КонтекстПоиска) Экспорт

	Аргументы = Новый Массив;

	Для каждого Арг Из ВходящиеАргументы Цикл
		Аргументы.Добавить(Арг);
	КонецЦикла;

	Результат = Новый Структура("РезультатПоиска, Аргументы", Ложь, Аргументы);
	Лог.Отладка("Начало поиска опции");
	Лог.Отладка("Количество входящих аргументов %1", Аргументы.Количество());

	Если Аргументы.Количество() = 0 
		ИЛИ КонтекстПоиска.СбросОпций Тогда
		Лог.Отладка("Не найдено аргументов <%1> или СбросОпций <%2>", Аргументы.Количество(), КонтекстПоиска.СбросОпций );

		Результат.РезультатПоиска = Опция.УстановленаИзПеременнойОкружения;
		Возврат Результат;

	КонецЕсли;

	Индекс = 0;
			
	Пока Индекс <= Аргументы.Вграница() Цикл
		
		ТекущийАргумент = Аргументы[Индекс];

		Если ТекущийАргумент = "-" Тогда
			Индекс = Индекс + 1;
			Продолжить;
		ИначеЕсли ТекущийАргумент = "--" Тогда
			Результат.РезультатПоиска = Опция.УстановленаИзПеременнойОкружения;
			Возврат Результат;
		ИначеЕсли СтрНачинаетсяС(ТекущийАргумент, "--") Тогда

			РезультатПоискаДлиннойОпции = НайтиДлиннуюОпцию(Аргументы, Индекс, КонтекстПоиска);
			Лог.Отладка("Длинная опция найдена: %1", РезультатПоискаДлиннойОпции.Найден);
			Если РезультатПоискаДлиннойОпции.Найден Тогда
				Результат.РезультатПоиска = Истина;
				Результат.Аргументы = РезультатПоискаДлиннойОпции.Аргументы;
				Возврат Результат;
				
			КонецЕсли;

			Если РезультатПоискаДлиннойОпции.ПрибавочныйИндекс = 0 Тогда
				Возврат Новый Структура("РезультатПоиска, Аргументы", Опция.УстановленаИзПеременнойОкружения, Аргументы);
			КонецЕсли;

			Индекс = Индекс + РезультатПоискаДлиннойОпции.ПрибавочныйИндекс;
		
		ИначеЕсли СтрНачинаетсяС(ТекущийАргумент, "-") Тогда

			РезультатПоискаКороткойОпции = НайтиКоротнуюОпцию(Аргументы, Индекс, КонтекстПоиска);
			Лог.Отладка("Короткая опция найдена: %1", РезультатПоискаКороткойОпции.Найден);
			Если РезультатПоискаКороткойОпции.Найден Тогда
				Результат.РезультатПоиска = Истина;
				Результат.Аргументы = РезультатПоискаКороткойОпции.Аргументы;
				Возврат Результат;
				
			КонецЕсли;
			
			Если РезультатПоискаКороткойОпции.ПрибавочныйИндекс = 0 Тогда
				Возврат Новый Структура("РезультатПоиска, Аргументы", Опция.УстановленаИзПеременнойОкружения, Аргументы);
			КонецЕсли;

			Индекс = Индекс + РезультатПоискаКороткойОпции.ПрибавочныйИндекс;
	
		Иначе
			Результат.РезультатПоиска = Опция.УстановленаИзПеременнойОкружения;
			Возврат Результат;
		КонецЕсли;

	КонецЦикла;

	Результат.РезультатПоиска = Опция.УстановленаИзПеременнойОкружения;
	Возврат Результат;

КонецФункции

Функция НайтиКоротнуюОпцию(Знач Аргументы, Индекс, КонтекстПоиска)
	Лог.Отладка("Класс опции %1", ТипЗнч(Опция));
	Лог.Отладка("Ищу короткую опцию %1", Опция.Имя);

	ТекущийАргумент = Аргументы[Индекс];

	Результат = Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 0, Аргументы);
	
	Если СтрДлина(ТекущийАргумент) < 2 Тогда
	
		Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 0, Аргументы);

	КонецЕсли;
	
	Если Сред(ТекущийАргумент, 3, 1) = "=" Тогда
		
		Имя = Лев(ТекущийАргумент, 2);

		КлассОпции = ОпцииИндекс[Имя];
		Если Не КлассОпции.имя = Опция.Имя Тогда
			Результат.ПрибавочныйИндекс  = 1;
			Возврат Результат;

		КонецЕсли; 
		
		Значение = Сред(ТекущийАргумент, 4);

		Если ПустаяСтрока(СокрЛП(Значение)) Тогда
			Возврат Результат;
		КонецЕсли;

		ОпцииКонтекст = КонтекстПоиска.Опции[Опция];
		Если ОпцииКонтекст = Неопределено Тогда
			ОпцииКонтекст = Новый Массив;
		КонецЕсли;
		ОпцииКонтекст.Добавить(Значение);
		КонтекстПоиска.Опции.Вставить(Опция, ОпцииКонтекст);
		
		Аргументы.Удалить(Индекс);
		Результат.ПрибавочныйИндекс  = 1;
		Результат.Аргументы  = Аргументы;
		Результат.Найден  = Истина;

		Возврат Результат;

	КонецЕсли;

	ЧтениеСтроки = Новый ЧтениеСтроки(ТекущийАргумент);
	ИщемОпцию = ЧтениеСтроки.ВЧтениеСтрокиС(1); 

	ИИ = 0;

	Лог.Отладка("Строка опции: %1", ИщемОпцию.ВСтроку(ИИ));

	Пока Не ПустаяСтрока(ИщемОпцию.ВСтрокуС(ИИ)) Цикл

		ИмяОпции = ИщемОпцию.ВСтроку(ИИ, ИИ);
		Лог.Отладка("ИмяОпции: %1", ИмяОпции);
		КлассОпции = ОпцииИндекс["-" + ИмяОпции];
		
		Лог.Отладка("КлассОпции: %1", Строка(КлассОпции));
		
		Если КлассОпции = Неопределено Тогда
			Лог.Отладка("Неопределенная опция: %1", Строка(ИмяОпции));
		
			Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 0, Аргументы);
		КонецЕсли;

		Лог.Отладка("КлассОпции.ТипОпции: %1 ", КлассОпции.ТипОпции);
		
		Если КлассОпции.ТипОпции = Тип("Булево") Тогда
			
			Если Не КлассОпции.Имя = Опция.Имя Тогда
				ИИ = ИИ + 1;
				Лог.Отладка("Не нашли опцию %1, %2 <> %3", ИмяОпции, КлассОпции.Имя,  Опция.Имя);
				Продолжить;
			КонецЕсли; 

			ОпцииКонтекст = КонтекстПоиска.Опции[Опция];
			Если ОпцииКонтекст = Неопределено Тогда
				ОпцииКонтекст = Новый Массив;
			КонецЕсли;
			ОпцииКонтекст.Добавить(Истина);
			Лог.Отладка("Добавили.значение <%2> опции <%1> в контекст", Опция.Имя , Истина);
			КонтекстПоиска.Опции.Вставить(Опция, ОпцииКонтекст);
			
			Результат.Найден  = Истина;
			Лог.Отладка("Вычисление остаточного ими от <%1> до индекса <%2> после индекса <%3> ",
						ИщемОпцию.ВСтроку(),
						ИщемОпцию.ВСтрокуПо(ИИ - 1),
						ИщемОпцию.ВСтрокуС(ИИ + 1));
			ОстаточноеИмя = ИщемОпцию.ВСтрокуПо(ИИ - 1) + ИщемОпцию.ВСтрокуС(ИИ + 1);
			Лог.Отладка("Остаточное имя <%1> опции ", ОстаточноеИмя );
			Если ПустаяСтрока(ОстаточноеИмя) Тогда
				Аргументы.Удалить(Индекс);
				Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Истина, 1, Аргументы);
			КонецЕсли;

			Аргументы[Индекс] = "-" + ОстаточноеИмя;
			Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Истина, 0, Аргументы);
		
		КонецЕсли;

		Значение = ИщемОпцию.ВСтрокуС(ИИ + 1);
			
		Если ПустаяСтрока(Значение) Тогда
			
			Если Аргументы.Вграница() - Индекс = 0 Тогда
				Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 0, Аргументы);
			КонецЕсли;		

			Если Не КлассОпции.имя = Опция.Имя Тогда
				Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 2, Аргументы);
			КонецЕсли; 

			Значение = Аргументы[Индекс + 1];
			Лог.Отладка("Значение найденной опции равно <%1>", Значение );
		
			Если СтрНачинаетсяС(Значение, "-") Тогда
				Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 0, Аргументы);
			КонецЕсли;
			
			ОпцииКонтекст = КонтекстПоиска.Опции[Опция];
			Если ОпцииКонтекст = Неопределено Тогда
				ОпцииКонтекст = Новый Массив;
			КонецЕсли;
			ОпцииКонтекст.Добавить(Значение);
			КонтекстПоиска.Опции.Вставить(Опция, ОпцииКонтекст);
			
			Лог.Отладка("Имя опции <%1> равно <%2> ", ИмяОпции, ИщемОпцию.ВСтроку());
		
			Если СтрДлина(ИмяОпции) = СтрДлина(ИщемОпцию.ВСтроку()) Тогда
				Аргументы.Удалить(Индекс);
				Аргументы.Удалить(Индекс); 
				
				Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Истина, 2, Аргументы);
			
			КонецЕсли;
			
			НовыйАргумент = СтрЗаменить(ИщемОпцию.ВСтроку(), ИмяОпции, "");
			Аргументы[Индекс] = "-" + НовыйАргумент;
			Аргументы.Удалить(Индекс + 1); // удаление значения,
					
			Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Истина, 1, Аргументы);

		КонецЕсли;

		Если Не КлассОпции.имя = Опция.Имя Тогда
			Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 1, Аргументы);
		КонецЕсли; 

		ОпцииКонтекст = КонтекстПоиска.Опции[Опция];
		Если ОпцииКонтекст = Неопределено Тогда
			ОпцииКонтекст = Новый Массив;
		КонецЕсли;
		Лог.Отладка("Значение найденной опции равно <%1>", Значение);
		
		ОпцииКонтекст.Добавить(Значение);
		КонтекстПоиска.Опции.Вставить(Опция, ОпцииКонтекст);
		
		ОстатокИмени = ИщемОпцию.ВСтрокуПо(ИИ - 1);
		Лог.Отладка("Остаток имени <%1>", ОстатокИмени);
		
		Если ПустаяСтрока(ОстатокИмени) Тогда
			Аргументы.Удалить(Индекс); // удаление значения, т.к. индекс уже сдвинулся.
			
			Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Истина, 1, Аргументы);
		
		КонецЕсли;
		
		Аргументы[Индекс] = "-" + ОстатокИмени;
		
		Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Истина, 0, Аргументы);
	
	КонецЦикла;

	Возврат  Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 1, Аргументы);

КонецФункции

Функция НайтиДлиннуюОпцию(Знач Аргументы, Индекс, КонтекстПоиска)
	Лог.Отладка("Класс опции %1", ТипЗнч(Опция));
	Лог.Отладка("Ищу длинную опцию %1", Опция.Имя);

	ТекущийАргумент = Аргументы[Индекс];
	
	МассивСтрокаАргумента = СтрРазделить(ТекущийАргумент, "=");
	
	ИмяОпции = МассивСтрокаАргумента[0];
	Лог.Отладка("Определели имя длинной опции %1", ИмяОпции);

	КлассОпции = ОпцииИндекс[ИмяОпции];
	Лог.Отладка("Класс опции по имени %1", КлассОпции);
	
	Если КлассОпции = Неопределено Тогда
		
		Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 0, Аргументы);

	КонецЕсли; 

	Если МассивСтрокаАргумента.Количество() = 2 Тогда
		
		Лог.Отладка("Строка содержит <=> второй элемент массива %1", МассивСтрокаАргумента[1]);

		Если Не КлассОпции.имя = Опция.Имя Тогда
			Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 1, Аргументы);
		КонецЕсли; 

		Значение = МассивСтрокаАргумента[1];

		Если ПустаяСтрока(Значение) Тогда
			Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 0, Аргументы);
		КонецЕсли;
		
		ОпцииКонтекст = КонтекстПоиска.Опции[Опция];
		Если ОпцииКонтекст = Неопределено Тогда
			ОпцииКонтекст = Новый Массив;
		КонецЕсли;
		ОпцииКонтекст.Добавить(Значение);
		Лог.Отладка("Значение длинной опции <%1>", Значение);
		КонтекстПоиска.Опции.Вставить(Опция, ОпцииКонтекст);
		
		Аргументы.Удалить(Индекс);
	
		Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Истина, 1, Аргументы);

	ИначеЕсли КлассОпции.ТипОпции = Тип("Булево") Тогда
		Если Не КлассОпции.имя = Опция.Имя Тогда
			Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 1, Аргументы);
		КонецЕсли; 
		
		ОпцииКонтекст = КонтекстПоиска.Опции[Опция];
		Если ОпцииКонтекст = Неопределено Тогда
			ОпцииКонтекст = Новый Массив;
		КонецЕсли;
		ОпцииКонтекст.Добавить(Истина);
		КонтекстПоиска.Опции.Вставить(Опция, ОпцииКонтекст);
		
		Аргументы.Удалить(Индекс);
	
		Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Истина, 1, Аргументы);
	
	Иначе

		Лог.Отладка("Разница между <%1> и %2 меньше 2", Аргументы.Вграница(), Индекс);

		Если Аргументы.Количество() - Индекс < 2 Тогда
			Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 0, Аргументы);
		КонецЕсли;

		Если Не КлассОпции.имя = Опция.Имя Тогда
			Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 2, Аргументы);
		КонецЕсли; 

		Значение = Аргументы[Индекс + 1];
		
		Если СтрНачинаетсяС(Значение, "-") Тогда
			Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 0, Аргументы);
		КонецЕсли;

		Лог.Отладка("Значение длинной опции <%1>", Значение);
		
		Если ПустаяСтрока(Значение) Тогда
			Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Ложь, 0, Аргументы);
		КонецЕсли;
		
		ОпцииКонтекст = КонтекстПоиска.Опции[Опция];
		Если ОпцииКонтекст = Неопределено Тогда
			ОпцииКонтекст = Новый Массив;
		КонецЕсли;
		ОпцииКонтекст.Добавить(Значение);
		КонтекстПоиска.Опции.Вставить(Опция, ОпцииКонтекст);
		
		Аргументы.Удалить(Индекс);
		Аргументы.Удалить(Индекс); // удаление значения, т.к. индекс уже сдвинулся.
			
		Возврат Новый Структура("Найден, ПрибавочныйИндекс, Аргументы", Истина, 1, Аргументы);

	КонецЕсли;
КонецФункции

// Возвращает приоритет текущего парсера
//
//  Возвращаемое значение:
//   число - приоритет текущего парсера
//
Функция Приоритет() Экспорт
	Возврат 1;
КонецФункции

// Возвращает имя текущего парсера
//
//  Возвращаемое значение:
//   строка - имя текущего парсера всегда начинается с "-" и добавляется имя опции
//
Функция ВСтроку() Экспорт
	Возврат "-" + Опция.Имя;
КонецФункции

Лог = Логирование.ПолучитьЛог("oscript.lib.cli_class_opt");