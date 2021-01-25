import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_bloc/network_helper.dart';
import 'package:weather_bloc/weather_model.dart';

class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  String _city;

  FetchWeather(this._city);
  @override
  // TODO: implement props
  List<Object> get props => [_city];
}

class ResetWeather extends WeatherEvent {

}

class WeatherState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherIsNotSearched extends WeatherState {

}

class WeatherIsLoading extends WeatherState {

}

class WeatherIsLoaded extends WeatherState {
   final _weather;

   WeatherIsLoaded(this._weather);

   @override
  // TODO: implement props
  List<Object> get props => [_weather];

   WeatherModel get getWeather => _weather;
}

class WeatherIsNotLoaded extends WeatherState {

}


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  NetworkHelper networkHelper;
  WeatherBloc(this.networkHelper) : super(WeatherIsNotSearched());


  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // TODO: implement mapEventToState
    if(event is FetchWeather) {
      yield WeatherIsLoading();

      try{
        WeatherModel weatherModel = await NetworkHelper().getWeather(event._city);
        yield WeatherIsLoaded(weatherModel);
      }catch(_){
        yield WeatherIsNotLoaded();
      }
    }else if(event is ResetWeather) {
      yield WeatherIsNotSearched();
    }
  }

}