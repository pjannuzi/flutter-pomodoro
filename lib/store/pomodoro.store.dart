import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TipoIntervalo { TRABALHO, DESCANSO }

abstract class _PomodoroStore with Store {

  @observable
  bool iniciado = false;

  @observable
  int tempoTrabalho = 30;

  @observable
  int tempoDescanso = 10;

  @observable
  int minutos = 30;

  @observable
  int segundos = 0;

  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.TRABALHO;

  Timer? cronometro;

  @action
  void iniciar() {
    iniciado = true;
    cronometro = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if(minutos == 0 && segundos == 0){
        _trocarTipoIntervalo();
      } else if (segundos == 0) {
        segundos = 59;
        minutos--;
      } else {
        segundos--;
      }
    });
  }

  @action
  void parar() {
    iniciado = false;
    cronometro?.cancel();
  }

  @action
  void reiniciar() {
    parar();
    minutos = estaTrabalhando() ? tempoTrabalho : tempoDescanso;
    segundos = 0;
  }

  @action
  incrementarTempoTrabalho() {
    for (var i = 1; i<=5; i++){
      tempoTrabalho++;
    }
    if(estaTrabalhando()){
      reiniciar();
    }
  }

  @action
  decrementarTempoTrabalho() {
    if(tempoTrabalho > 1) {
      for (var i = 1; i<=5; i++){
        tempoTrabalho--;
      }
      if (estaTrabalhando()) {
        reiniciar();
      }
    }
  }

  @action
  incrementarTempoDescanso() {
    for (var i = 1; i<=5; i++){
      tempoDescanso++;
    }
    if (estaDescansando()) {
      reiniciar();
    }
  }

  @action
  decrementarTempoDescanso() {
    if(tempoDescanso > 1) {
      for (var i = 1; i<=5; i++){
        tempoDescanso--;
      }
      if (estaDescansando()) {
        reiniciar();
      }
    }
  }

  bool estaTrabalhando() {
    return tipoIntervalo == TipoIntervalo.TRABALHO;
  }

  bool estaDescansando() {
    return tipoIntervalo == TipoIntervalo.DESCANSO;
  }

  void _trocarTipoIntervalo() {
    if(estaTrabalhando()) {
      tipoIntervalo = TipoIntervalo.DESCANSO;
      minutos = tempoDescanso;
    } else {
      tipoIntervalo = TipoIntervalo.TRABALHO;
      minutos = tempoTrabalho;
    }
    segundos = 0;
  }

}