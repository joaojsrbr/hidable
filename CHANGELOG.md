# v0.0.1

**Adicionar efeito de rolagem para ocultar a qualquer widget localizado estático - AppBar, BottomNavigationBar, etc.**

#### Widget Rolável

```dart
ListView.separated(
  // ScrollController
  // ListView e Hidable widget.
  controller: scrollController,
  itemCount: colors.length,
  itemBuilder: (_, i) => Container(
     height: 50,
     color: colors[i].withOpacity(.6),
  ),
  separatorBuilder: (_, __) => const SizedBox(height: 10),
),
```

#### Widget ocultável localizado estático

```dart
Hidable(
  controllers: [scrollController] // Lista de ScrollController,
  wOpacity: true, // Valor padrão: true.
  size: 56, // Valor padrão: 56.
  child: BottomNavigationBar(...),
),
```
