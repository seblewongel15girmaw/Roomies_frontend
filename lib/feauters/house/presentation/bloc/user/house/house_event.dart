
abstract class HouseEvent{}

class InitialEvent extends HouseEvent{}

class AddToFavoriteHouseEvent extends HouseEvent{}

class HouseDetailEvent extends HouseEvent{}

class FilterClickedEvent extends HouseEvent{
  int numOfRoom;
  FilterClickedEvent(this.numOfRoom);
}
class RemoveFromFavoriteHouseEvent extends HouseEvent{}