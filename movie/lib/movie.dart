library movie;

//data
export 'data/datasources/db/movie_database_helper.dart';
export 'data/datasources/movie_local_data_source.dart';
export 'data/datasources/movie_remote_data_source.dart';
export 'data/models/movie_detail_model.dart';
export 'data/models/movie_model.dart';
export 'data/models/movie_response.dart';
export 'data/models/movie_table.dart';
export 'data/repositories/movie_repository_impl.dart';
//domain
export 'domain/entities/movie.dart';
export 'domain/entities/movie_detail.dart';
export 'domain/repositories/movie_repository.dart';
export 'domain/usecases/get_movie_detail.dart';
export 'domain/usecases/get_movie_recommendations.dart';
export 'domain/usecases/get_now_playing_movies.dart';
export 'domain/usecases/get_popular_movies.dart';
export 'domain/usecases/get_top_rated_movies.dart';
export 'domain/usecases/get_watchlist_movies.dart';
export 'domain/usecases/get_watchlist_status.dart';
export 'domain/usecases/remove_watchlist.dart';
export 'domain/usecases/save_watchlist.dart';
export 'domain/usecases/search_movies.dart';
//presentation
export 'presentation/pages/home_movie_page.dart';
export 'presentation/pages/movie_detail_page.dart';
export 'presentation/pages/popular_movies_page.dart';
export 'presentation/pages/search_page_movies.dart';
export 'presentation/pages/top_rated_movies_page.dart';
export 'presentation/pages/watchlist_movies_page.dart';
export 'presentation/widgets/movie_card_list.dart';
//bloc
export 'presentation/bloc/search_movies/search_movie_bloc.dart';
export 'presentation/bloc/now_playing_movies/now_playing_movie_bloc.dart';
export 'presentation/bloc/popular_movies/popular_movie_bloc.dart';
export 'presentation/bloc/top_rated_movies/top_rated_movie_bloc.dart';
export 'presentation/bloc/detail_movies/detail_movie_bloc.dart';
export 'presentation/bloc/recommendations_movies/recommendations_movie_bloc.dart';
export 'presentation/bloc/watchlist_movies/watchlist_movie_bloc.dart';
