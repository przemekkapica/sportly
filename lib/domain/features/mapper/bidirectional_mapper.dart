abstract class BidirectionalDataMapper<Dto, Model> {
  Dto toDto(Model data);

  Model fromDto(Dto dto);
}
