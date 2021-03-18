
import 'package:wigilabsSpotify/modelos/autorizacionModelo.dart';
import 'package:wigilabsSpotify/servicios/spotify/repositoryServicio.dart';
import 'package:rxdart/rxdart.dart';

class AutorizacionBloc {
  final _repository = RepositoryAuthorization();

  final PublishSubject autorizacionTokenLista = PublishSubject<AuthorizationModel>();
  final PublishSubject autorizacionCodigoLista = PublishSubject<String>();

  Observable<String> get authorizationCode => autorizacionCodigoLista.stream;
  Observable<AuthorizationModel> get authorizationToken => autorizacionTokenLista.stream;

  fetchAuthorizationCode() async {
    String code = await _repository.fetchAuthorizationCode();
    autorizacionCodigoLista.sink.add(code);
  }

  fetchAuthorizationToken(String code) async {
    AuthorizationModel authorizationModel = await _repository.fetchAuthorizationToken(code);
    autorizacionTokenLista.sink.add(authorizationModel);
  }

  disposeCode() {
    autorizacionCodigoLista.close();
  }

  disposeToken() {
    autorizacionTokenLista.close();
  }
}

final AutorizacionBloc autorizacionBloc = AutorizacionBloc();