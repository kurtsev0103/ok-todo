# ok-todo (Zadanie testowe)

## Requirements

| Version | Obsługa orientacji | CoreData | Without Storyboard | Unit Tests |
| :-----: | :----------------: | :------: | :----------------: | :--------: |
| iOS 13.0+ | pionowa / pozioma | ✅ | ✅ | ❌ |

<img width="200" alt="img" src="https://user-images.githubusercontent.com/27446881/145494393-bbaf7648-3f35-4f48-a3aa-396cd0d5257c.gif">

## 🎯 Napisz prostą aplikację TODO APP

|     | Stan | Zadanie | 
| :-: | :--: | :----- |
| **1.** | ✅ | Aplikacja będzie umożliwiała dodawanie/usuwanie zadań do/z listy Twoich zadań do wykonania. |
| **2.** | ✅ | Po wejściu do aplikacji widzimy listę zaplanowanych zadań oraz przycisk dodawania nowego zadania. |
| **3.** | ✅ | W przypadku gdy nie dodaliśmy jeszcze żadnego zadania, powinien zostać wyświetlony stosowny komunikat. |
| **4.** | ✅ | Po kliknięciu przycisku dodawania zadań aplikacja przenosi nas na nowe okno, gdzie uzupełniamy dane: nazwę, datę wykonania oraz kategorię zadania (jedną z: praca, zakupy, inne). Każda dana powinna być wprowadzana/wybierana w oddzielnej kontrolce. |
| **5.** | ✅ | Na ekranie dodatkowo obsługujemy dwa przyciski: Dodaj zadanie oraz Anuluj. Po ich kliknięciu aplikacja cofa nas do okna z listą zadań. |
| **6.** | ✅ | Po poprawnym dodaniu zadania do listy wyświetlany jest komunikat o powodzeniu operacji. |
| **7.** | ✅ | W przypadku niepowodzenia zapisu wyświetlany jest Dialog z opcją ponowienia operacji. |
| **8.** | ✅ | Jeśli operacja zakończyła się powodzeniem, lista powinna zostać odświeżona automatycznie. |
| **9.** | ✅ | Zapisane zadania muszą być zapisywane w pamięci urządzenia. |
| **10.** | ✅ | Aplikacja musi działać poprawnie zarówno w orientacji pionowej jak i poziomej. |
| **11.** | ✅ | Zastosowanie różnego wyglądu wpisów z różnych kategorii będzie dodatkowym atutem. Przykład: Wpisy z kategorii 'praca' wyświetlane na zielonym tle, z ikonką notesu, kolor tekstu biały. Wpisy z kategorii 'zakupy' wyświetlane na niebieskim tle, bez ikonki, kolor tekstu żółty. Oczywiście to tylko sugestie, można zastosować własne stylowanie. |
| **12.** | ✅ | Usunięcie wpisu odbywa się z poziomu widoku listy, przed tą operacją powinien być wyświetlony komunikat z prośbą o potwierdzenie. Usunięcie nastąpi jedynie wtedy, gdy użytkownik zatwierdzi operację. Po usunięciu lista powinna wyświetlać aktualną listę zadań. |

## ⭐️ Dodatki

 - Początkowe "kategorie" odpowiadają paragrafowi ```#11``` Wszystkie kolory są przestrzegane zgodnie z warunkami.
 - Wszystkie kategorie są przechowywane w CoreData. Można je odpowiednio usuwać i dodawać nowe.
 - Zarówno w kategoriach standardowych jak i nowych można wybrać dowolny kolor tekstu oraz kolor tła.
 - W kategoriach standardowych i nowych można wybrać dowolną ikonę z galerii, jak również ją usunąć.
 - Zadania, które zostały już utworzone, można edytować, klikając na nie na liście wszystkich zadań.
 - Pole wyboru "data" podczas tworzenia zadania wygląda tak samo zarówno w systemie iOS 13.0, jak i iOS >= 13.4. 
    > W iOS < 13.4 DatePicker pojawia się w miejscu klawiatury, a w iOS >= 13.4 w nowym stylu popover.

## Created by Oleksandr Kurtsev (Copyright © 2021) [LICENSE](https://github.com/kurtsev0103/ok-todo/blob/main/LICENSE)
