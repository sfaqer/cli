#использовать "../src"
#Использовать asserts

Перем юТест;

Функция ПолучитьСписокТестов(Знач Тестирование) Экспорт

	юТест = Тестирование;
	
	ИменаТестов = Новый Массив;
	
	ИменаТестов.Добавить("ТестДолжен_ПроверитьСпекЛексер");
	
	Возврат ИменаТестов;

КонецФункции



Процедура ТестДолжен_ПроверитьСпекЛексер() Экспорт
	
	ПроверочныеДанные = ТестовыеСлучаи();
	
	Для каждого КлючЗначение Из ПроверочныеДанные Цикл
		
		Сообщить("Проверяю spec: " + КлючЗначение.Ключ);
		СпекМассив = СпекЛексер.ПолучитьСпекТокены(КлючЗначение.Ключ);
		//Сообщить("  "+ СпекМассив[0].Тип);
		
		СверитьМассивыТокенов(СпекМассив, КлючЗначение.Значение);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура СверитьТокены(ПроверяемыйТокен, ИдеальныйТокен)
	
	
	Для каждого КлючЗначение Из ИдеальныйТокен Цикл
		
		Если Не КлючЗначение.Значение = ПроверяемыйТокен[КлючЗначение.Ключ] Тогда
			Сообщить(СтрШаблон("Ошибка проверки токена: %1 = %2", КлючЗначение.Значение, ПроверяемыйТокен[КлючЗначение.Ключ]));
			СпекЛексер.СообщитьТокен(ПроверяемыйТокен);

		КонецЕсли;

	КонецЦикла;


КонецПроцедуры

Процедура СверитьМассивыТокенов(ПроверяемыйМассив, ИдеальныйМассив)

	Если Не ПроверяемыйМассив.Количество() = ИдеальныйМассив.Количество() Тогда
		Сообщить("массивы не равно");
		Возврат;
	КонецЕсли;

	Для ИндексТокена = 0 По ИдеальныйМассив.Количество() -1 Цикл
		
		

		ИдеальныйТокен = ИдеальныйМассив[ИндексТокена];
		ПроверяемыйТокен = ПроверяемыйМассив[ИндексТокена];
		СверитьТокены(ПроверяемыйТокен, ИдеальныйТокен);
		
	КонецЦикла

	
КонецПроцедуры


Функция ПравильныйОтвет(Ответ1, Ответ2 = Неопределено, Ответ3 = Неопределено, Ответ4 = Неопределено, Ответ5 = Неопределено, Ответ6 = Неопределено, Ответ7 = Неопределено) 

	Массив = Новый Массив;

	Массив.Добавить(Ответ1);

	Если ЗначениеЗаполнено(Ответ2) Тогда
		Массив.Добавить(Ответ2);
	КонецЕсли;
	Если ЗначениеЗаполнено(Ответ3) Тогда
		Массив.Добавить(Ответ3);
	КонецЕсли;
	Если ЗначениеЗаполнено(Ответ4) Тогда
		Массив.Добавить(Ответ4);
	КонецЕсли;
	Если ЗначениеЗаполнено(Ответ5) Тогда
		Массив.Добавить(Ответ5);
	КонецЕсли;
	Если ЗначениеЗаполнено(Ответ6) Тогда
		Массив.Добавить(Ответ6);
	КонецЕсли;
	Если ЗначениеЗаполнено(Ответ7) Тогда
		Массив.Добавить(Ответ7);
	КонецЕсли;

	Возврат Массив;
	
КонецФункции


Функция ТестовыеСлучаи()

	ПроверочныеДанные = Новый Соответствие;
	
	ПроверочныеДанные.Вставить("XOPTIONS", ПравильныйОтвет(СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "XOPTIONS", 1)));
	ПроверочныеДанные.Вставить("OPTIONSX", ПравильныйОтвет(СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "OPTIONSX", 1)));
	ПроверочныеДанные.Вставить("ARG_EXTRA", ПравильныйОтвет(СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG_EXTRA", 1)));
	ПроверочныеДанные.Вставить("OPTIONS", ПравильныйОтвет(СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOptions, "OPTIONS", 1)));
	
	ПроверочныеДанные.Вставить("ARG1 ARG2", ПравильныйОтвет(СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG1", 1),СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG2", 6)));
	ПроверочныеДанные.Вставить("ARG1  ARG2", ПравильныйОтвет(СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG1", 1), СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG2", 7)));

	ПроверочныеДанные.Вставить("(", ПравильныйОтвет(СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOpenPar, "(", 1)));
	ПроверочныеДанные.Вставить(")", ПравильныйОтвет(СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTClosePar, ")", 1)));
	
	ПроверочныеДанные.Вставить("...", ПравильныйОтвет(СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTRep, "...", 1)));
	ПроверочныеДанные.Вставить("ARG...", ПравильныйОтвет(СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG", 1),СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTRep, "...", 4)));
	

	ПроверочныеДанные.Вставить("|", ПравильныйОтвет(СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTChoice, "|", 1)));
	ПроверочныеДанные.Вставить("ARG1 |ARG2", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG1", 1),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTChoice, "|", 6),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG2", 7)
		)
	);
	ПроверочныеДанные.Вставить("ARG1| ARG2", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG1", 1),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTChoice, "|", 5),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG2", 7)
		)
	);

	ПроверочныеДанные.Вставить("ARG1|ARG2", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG1", 1),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTChoice, "|", 5),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG2", 6)
		)
	);

	ПроверочныеДанные.Вставить("(ARG)", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOpenPar, "(", 1),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG", 2),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTClosePar, ")", 5)
		)
	);
	ПроверочныеДанные.Вставить("( -v | -s -b )", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOpenPar, "(", 1),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTShortOpt, "-v", 3),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTChoice, "|", 6),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTShortOpt, "-s", 8),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTShortOpt, "-b", 11),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTClosePar, ")", 14)
		)
	);

	

	ПроверочныеДанные.Вставить("( ARG )", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOpenPar, "(", 1),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG", 3),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTClosePar, ")", 7)
		)
	);

	ПроверочныеДанные.Вставить("[ARG]", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOpenSq, "[", 1),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG", 2),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTCloseSq, "]", 5)
		)
	);

	ПроверочныеДанные.Вставить("[ ARG ]", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOpenSq, "[", 1),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG", 3),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTCloseSq, "]", 7)
		)
	);

	ПроверочныеДанные.Вставить("ARG [ARG2 ]", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG", 1),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOpenSq, "[", 5),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG2", 6),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTCloseSq, "]", 11)
		)
	);

	ПроверочныеДанные.Вставить("ARG [ ARG2]", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG", 1),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOpenSq, "[", 5),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTArg, "ARG2", 7),
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTCloseSq, "]", 11)
		)
	);

	ПроверочныеДанные.Вставить("-p", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTShortOpt, "-p", 1),
		)
	);
	ПроверочныеДанные.Вставить(" -x", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTShortOpt, "-x", 2),
		)
	);
	ПроверочныеДанные.Вставить("--force", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTLongOpt, "--force", 1),
		)
	);
	ПроверочныеДанные.Вставить("--sig-proxy", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTLongOpt, "--sig-proxy", 1),
		)
	);

	ПроверочныеДанные.Вставить("-aBc", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOptSeq, "-aBc", 1),
		)
	);
	ПроверочныеДанные.Вставить("--", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTDoubleDash, "--", 1),
		)
	);
	
	
	ПроверочныеДанные.Вставить("=<bla>", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOptValue, "=<bla>", 1),
		)
	);
	
	ПроверочныеДанные.Вставить("=<bla>", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOptValue, "=<bla>", 1),
		)
	);
	
	ПроверочныеДанные.Вставить("=<bla-bla>", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOptValue, "=<bla-bla>", 1),
		)
	);
	
	ПроверочныеДанные.Вставить("=<bla--bla>", ПравильныйОтвет(
		СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOptValue, "=<bla--bla>", 1),
		)
	);
	
	// ПроверочныеДанные.Вставить("-p=<file-path>", ПравильныйОтвет(
	// 	СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTShortOpt, "-p", 1),
	// 	СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOptValue, "=<file-path>", 5),
	// 	)
	// );

	// ПроверочныеДанные.Вставить("--path=<file-path>", ПравильныйОтвет(
	// 	СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTLongOpt, "--path", 1),
	// 	СпекЛексер.НовыйТокен(СпекЛексер.ТипыТокенов().TTOptValue, "=<file-path>", 7),
	// 	)
	// );
	
	// {"-p=<file-path>", []*Token{{TTShortOpt, "-p", 0}, {TTOptValue, "=<file-path>", 2}}},
	// {"--path=<absolute-path>", []*Token{{TTLongOpt, "--path", 0}, {TTOptValue, "=<absolute-path>", 6}}},

	Возврат ПроверочныеДанные

КонецФункции	