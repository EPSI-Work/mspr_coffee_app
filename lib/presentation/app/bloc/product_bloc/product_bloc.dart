import 'package:bloc/bloc.dart';
import 'package:mspr_coffee_app/common/error/app_exception.dart';
import 'package:mspr_coffee_app/domain/entities/entity.dart';
import 'package:equatable/equatable.dart';
import 'package:mspr_coffee_app/domain/repositories/product_repository/product_repository.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository _productRepository = ProductRepository();
  ProductBloc() : super(const ProductState()) {
    on<ProductReset>(_onReset);
    on<ProductSelect>(_onSelect);
    on<ProductFetchAll>(_onFetchAll);
    on<ProductFetchOne>(_onFetchOne);
  }

  _onSelect(
    ProductSelect event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(
      status: ProductStatus.select,
      product: event.product,
    ));
  }

  _onReset(
    ProductReset event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(
      status: ProductStatus.initial,
    ));
  }

  _onFetchAll(
    ProductFetchAll event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(
      status: ProductStatus.inProgress,
    ));
    try {
      await _productRepository.getAll().then((value) {
        emit(state.copyWith(
          status: ProductStatus.success,
          products: value,
        ));
      }).onError((AppException error, stackTrace) {
        emit(state.copyWith(
          status: ProductStatus.failure,
          message: error.message,
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        message: e.toString(),
      ));
    }
  }

  _onFetchOne(
    ProductFetchOne event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(
      status: ProductStatus.inProgress,
    ));
    await _productRepository.getOne(id: event.id).then((value) {
      emit(state.copyWith(
        status: ProductStatus.success,
        product: value,
      ));
    }).onError((AppException error, stackTrace) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        message: error.message,
      ));
    });
  }
}
