Перем Опции Экспорт; // Структура Ключ - Значение (Структура описание опции)
Перем Аргументы Экспорт; // Структура  

Перем НеВключенныеОпции; // Структура Ключ - Значение (Структура описание опции)
Перем СбросОпций Экспорт;

Процедура ПрисоеденитьКонтекст(Знач ВходящийКоннекст)
	
	Для каждого ВходящаяОпция Из ВходящийКоннекст.Опции Цикл
		
		Если ВходящаяОпция.Значение = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		АргументКонтекст = Аргументы.Аргументы[ВходящаяОпция.Ключ];
		Если АргументКонтекст = Неопределено Тогда
			АргументКонтекст = Новый Массив;
		КонецЕсли;

		Для каждого ЭлементМассива Из ВходящаяОпция.Значение Цикл
			АргументКонтекст.Добавить(Аргументы[0]);
		КонецЦикла;

		Аргументы.Вставить(ВходящаяОпция.Ключ, АргументКонтекст);

	КонецЦикла;


КонецПроцедуры

Опции = Новый Соответствие;
Аргументы = Новый Соответствие;
НеВключенныеОпции = Новый Соответствие;
СбросОпций = Ложь;