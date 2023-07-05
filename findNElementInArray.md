### Поиск 3 самых распространенных елементов в массиве, мы говорили про решение на основе сортировки бинарным делением

Правильный ответ: решение на базе алгоритма Бойера — Мура, будет быстрее и сложнее

Мой ответ: 
Нам нужно выбрать некоторый опорный индекс в массиве. Будем перемещать елементы так что бы елементы которые встречаются чаще были слева от точки опоры, а те которые реже - справа.
Повторять до тех пор пока условие не будет выполнено, после возьмем нужно количество N елементов в начале отсортированого куска, алгоритм линейный по памяти и времени 


Пишу на свифт, он почти как псевдокод:

```swift

func nMostFreqElement(in array:[Int], numberOfelements n:Int) -> [Int]{
	
	var counterStore = [Int,Int]() // тут храним количество вхождений каждого елемента
	array.forEach { element in
		counterStore[element] += 1
	}      /// считаем число вхождений каждого елемента [1,2,1] => [1:2, 2:1]


	var frequencyStore = [ (Int,Int) ]() //а тут храним частоту встречь каждого елемента
	counterStore.{ key, value in
		frequencyStore.append((value, key))
	}      


	quickSelect(frequencyStore, frequencyStore.count - n, 0, frequencyStore.size - 1) //производим быстрый выбор
	let result = [Int] // масив ответ

	for i in 0...n {
    	result[i] = frequencyStore[frequencyStore.count - 1 - i].0; // берем сколько елементов сколько нам нужно
	}

	return result
}

func quickSelect(frequencyStore: inout [ (Int,Int) ], rezultSize:Int, min:Int, max:Int) {
	
	if min == max { // выходим из рекурсии 
	 	return;         
	}
       
    let position:Int = binnaryPossition(freqArray, min, max) // находим позицию для опорного елемента
    if rezultSize <= position) {  /////Будем повторять до тех пор пока результат не сойдется
    	QuickSelect(frequencyStore, rezultSize, min, position);
    } else {
      	QuickSelect(frequencyStore, rezultSize, position + 1, max); 
    }

}

private int binnaryPossition(frequencyStore: inout [ (Int,Int) ], min:Int, max:Int) -> Int
{
    let mid = main + (max - min) / 2;
    let pivot = frequencyStore[mid].1;   // каждый раз стартуем с середины куска массива

    let left = min - 1;
    let right = max + 1;
    while true      
    {
        while (freqArray[left].1 < pivot)
        {
            left +=1;
        } 

        while (freqArray[right].1 > pivot)
        {
            right -=1;
        } 

        if left >= right {
        	return right
        }

        let temp = freqArray[left]

        frequencyStore[left] = freqArray[right]

        frequencyStore[right] = temp     /// меняем елементы меставми до тех пор пока все елементы слева не будут больше всех елементов справа
    }
}
```

