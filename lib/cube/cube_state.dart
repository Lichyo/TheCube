import 'package:cy_cube/cube/cube_view/cube_component.dart';
import 'cube_model/single_cube_model.dart';
import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_model/single_cube_component_face_model.dart';
import 'cube_constants.dart';
import '../components/single_cube_face.dart';

class CubeState {
  static List<SingleCubeModel> cubeModels = [];
  static List<int> indexWithStack = [];
  bool isInit = false;
  Function()? onStateChange;

  static bool isFirstAdjustRight = false;
  static bool isFirstAdjustLeft = false;

  CubeState() {
    int id = 0;
    for (int z = -1; z < 2; z++) {
      for (int y = -1; y < 2; y++) {
        for (int x = -1; x < 2; x++) {
          cubeModels.add(
            SingleCubeModel(
              component: CubeComponent(
                cubeColor: Map.from(defaultCubeColor),
              ),
              x: x * cubeWidth,
              y: -y * cubeWidth,
              z: z * cubeWidth,
            ),
          );
          indexWithStack.add(id);
          id++;
        }
      }
    }
    // arrangeCubeFace('right'); ????
  }

  final Map<Facing, Color> defaultCubeColor = {
    Facing.top: Colors.white,
    Facing.down: Colors.yellow,
    Facing.right: Colors.red,
    Facing.left: Colors.orange,
    Facing.front: Colors.green,
    Facing.back: Colors.blue,
  };

  void setOnStateChange(Function()? callback) {
    onStateChange = callback;
  }

  void _updateCubeComponent({
    required List<int> ids,
    required String axis,
  }) {
    for (int id in ids) {
      Map<Facing, Color> updatedCubeColor = {};
      if (axis == 'x') {
        updatedCubeColor = _updateXColor(cube: cubeModels[id]);
      } else if (axis == 'xx') {
        updatedCubeColor = _updateXColorReverse(cube: cubeModels[id]);
      } else if (axis == 'y') {
        updatedCubeColor = _updateYColor(cube: cubeModels[id]);
      } else if (axis == 'yy') {
        updatedCubeColor = _updateYColorReverse(cube: cubeModels[id]);
      } else if (axis == 'z') {
        updatedCubeColor = _updateZColor(cube: cubeModels[id]);
      } else {
        updatedCubeColor = _updateZColorReverse(cube: cubeModels[id]);
      }
      cubeModels[id] = SingleCubeModel(
        component: CubeComponent(
          cubeColor: updatedCubeColor,
        ),
        x: cubeModels[id].x,
        y: cubeModels[id].y,
        z: cubeModels[id].z,
      );
    }
  }

  void rotate(String rotation) {
    if (rotation == 'U') {
      uMove();
    } else if (rotation == 'U\'') {
      uMoveReverse();
    } else if (rotation == 'D') {
      dMove();
    } else if (rotation == 'D\'') {
      dMoveReverse();
    } else if (rotation == 'R') {
      rMove();
    } else if (rotation == 'R\'') {
      rMoveReverse();
    } else if (rotation == 'L') {
      lMove();
    } else if (rotation == 'L\'') {
      lMoveReverse();
    } else if (rotation == 'F') {
      fMove();
    } else if (rotation == 'F\'') {
      fMoveReverse();
    } else if (rotation == 'B') {
      bMove();
    } else if (rotation == 'B\'') {
      bMoveReverse();
    } else if (rotation == '') {}
    if (onStateChange != null) {
      onStateChange!();
    }
  }

  void rMove() {
    _updateCubeComponent(ids: [26, 20, 2, 8, 5, 17, 23, 11], axis: 'x');
    _shift([26, 20, 2, 8], [5, 17, 23, 11]);
  }

  void rMoveReverse() {
    _updateCubeComponent(ids: [8, 2, 20, 26, 11, 23, 17, 5], axis: 'xx');
    _shift([8, 2, 20, 26], [11, 23, 17, 5]);
  }

  void lMove() {
    _updateCubeComponent(ids: [6, 0, 18, 24, 15, 3, 9, 21], axis: 'xx');
    _shift([6, 0, 18, 24], [15, 3, 9, 21]);
  }

  void lMoveReverse() {
    _updateCubeComponent(ids: [24, 18, 0, 6, 21, 15, 3, 9], axis: 'x');
    _shift([24, 18, 0, 6], [21, 9, 3, 15]);
  }

  void fMove() {
    _updateCubeComponent(ids: [20, 26, 24, 18, 19, 23, 25, 21], axis: 'y');
    _shift([20, 26, 24, 18], [19, 23, 25, 21]);
  }

  void fMoveReverse() {
    _updateCubeComponent(ids: [18, 24, 26, 20, 21, 25, 23, 19], axis: 'yy');
    _shift([18, 24, 26, 20], [21, 25, 23, 19]);
  }

  void bMove() {
    _updateCubeComponent(ids: [6, 8, 2, 0, 5, 7, 3, 1], axis: 'yy');
    _shift([6, 8, 2, 0], [7, 5, 1, 3]);
  }

  void bMoveReverse() {
    _updateCubeComponent(ids: [0, 2, 8, 6, 1, 3, 7, 5], axis: 'y');
    _shift([0, 2, 8, 6], [3, 1, 5, 7]);
  }

  void uMove() {
    _updateCubeComponent(ids: [8, 6, 24, 26, 17, 7, 15, 25], axis: 'z');
    _shift([8, 6, 24, 26], [17, 7, 15, 25]);
  }

  void uMoveReverse() {
    _updateCubeComponent(ids: [26, 24, 6, 8, 25, 15, 7, 17], axis: 'zz');
    _shift([26, 24, 6, 8], [25, 15, 7, 17]);
  }

  void dMove() {
    _updateCubeComponent(ids: [2, 20, 18, 0, 11, 1, 9, 19], axis: 'zz');
    _shift([2, 20, 18, 0], [1, 11, 19, 9]);
  }

  void dMoveReverse() {
    _updateCubeComponent(ids: [0, 18, 20, 2, 19, 9, 1, 11], axis: 'z');
    _shift([0, 18, 20, 2], [9, 19, 11, 1]);
  }

  Map<Facing, Color> _updateXColor({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color topColor = cubeColor[Facing.top]!;
    cubeColor[Facing.top] = cubeColor[Facing.front]!;
    cubeColor[Facing.front] = cubeColor[Facing.down]!;
    cubeColor[Facing.down] = cubeColor[Facing.back]!;
    cubeColor[Facing.back] = topColor;
    return cubeColor;
  }

  Map<Facing, Color> _updateXColorReverse({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color color = cubeColor[Facing.back]!;
    cubeColor[Facing.back] = cubeColor[Facing.down]!;
    cubeColor[Facing.down] = cubeColor[Facing.front]!;
    cubeColor[Facing.front] = cubeColor[Facing.top]!;
    cubeColor[Facing.top] = color;
    return cubeColor;
  }

  Map<Facing, Color> _updateYColorReverse({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color color = cubeColor[Facing.top]!;
    cubeColor[Facing.top] = cubeColor[Facing.right]!;
    cubeColor[Facing.right] = cubeColor[Facing.down]!;
    cubeColor[Facing.down] = cubeColor[Facing.left]!;
    cubeColor[Facing.left] = color;
    return cubeColor;
  }

  Map<Facing, Color> _updateYColor({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color color = cubeColor[Facing.left]!;
    cubeColor[Facing.left] = cubeColor[Facing.down]!;
    cubeColor[Facing.down] = cubeColor[Facing.right]!;
    cubeColor[Facing.right] = cubeColor[Facing.top]!;
    cubeColor[Facing.top] = color;
    return cubeColor;
  }

  Map<Facing, Color> _updateZColor({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color color = cubeColor[Facing.left]!;
    cubeColor[Facing.left] = cubeColor[Facing.front]!;
    cubeColor[Facing.front] = cubeColor[Facing.right]!;
    cubeColor[Facing.right] = cubeColor[Facing.back]!;
    cubeColor[Facing.back] = color;
    return cubeColor;
  }

  Map<Facing, Color> _updateZColorReverse({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color color = cubeColor[Facing.back]!;
    cubeColor[Facing.back] = cubeColor[Facing.right]!;
    cubeColor[Facing.right] = cubeColor[Facing.front]!;
    cubeColor[Facing.front] = cubeColor[Facing.left]!;
    cubeColor[Facing.left] = color;
    return cubeColor;
  }

  void _shift(List<int> cornerIds, List<int> edgeIds) {
    final CubeComponent cornerComponent = cubeModels[cornerIds[0]].component;
    cubeModels[cornerIds[0]].component = cubeModels[cornerIds[1]].component;
    cubeModels[cornerIds[1]].component = cubeModels[cornerIds[2]].component;
    cubeModels[cornerIds[2]].component = cubeModels[cornerIds[3]].component;
    cubeModels[cornerIds[3]].component = cornerComponent;

    final CubeComponent edgeComponent = cubeModels[edgeIds[0]].component;
    cubeModels[edgeIds[0]].component = cubeModels[edgeIds[1]].component;
    cubeModels[edgeIds[1]].component = cubeModels[edgeIds[2]].component;
    cubeModels[edgeIds[2]].component = cubeModels[edgeIds[3]].component;
    cubeModels[edgeIds[3]].component = edgeComponent;
  }

  void _setupSingleFace({
    required List<int> cubeIDs,
    required List<SingleCubeComponentFaceModel> cubeFaces,
    required Facing facing,
  }) {
    int i = 0;
    for (int id in cubeIDs) {
      Map<Facing, Color> updatedCubeColor =
          Map.from(cubeModels[id].component.cubeColor);
      updatedCubeColor[facing] = cubeFaces[i].color!;
      cubeModels[id] = SingleCubeModel(
        component: CubeComponent(
          cubeColor: updatedCubeColor,
        ),
        x: cubeModels[id].x,
        y: cubeModels[id].y,
        z: cubeModels[id].z,
      );
      i++;
    }
  }

  void setupCubeWithScanningColor(
      List<List<SingleCubeComponentFaceModel>> cubeFaces) {
    for (int i = 0; i < cubeFaces.length; i++) {
      if (cubeFaces[i][4].color == Colors.white) {
        _setupSingleFace(
          cubeIDs: [24, 25, 26, 15, 16, 17, 6, 7, 8],
          cubeFaces: cubeFaces[i],
          facing: Facing.top,
        );
      } else if (cubeFaces[i][4].color == Colors.yellow) {
        _setupSingleFace(
          cubeIDs: [0, 1, 2, 9, 10, 11, 18, 19, 20],
          cubeFaces: cubeFaces[i],
          facing: Facing.down,
        );
      } else if (cubeFaces[i][4].color == Colors.red) {
        _setupSingleFace(
          cubeIDs: [20, 11, 2, 23, 14, 5, 26, 17, 8],
          cubeFaces: cubeFaces[i],
          facing: Facing.right,
        );
      } else if (cubeFaces[i][4].color == Colors.orange) {
        _setupSingleFace(
          cubeIDs: [0, 9, 18, 3, 12, 21, 6, 15, 24],
          cubeFaces: cubeFaces[i],
          facing: Facing.left,
        );
      } else if (cubeFaces[i][4].color == Colors.blue) {
        _setupSingleFace(
          cubeIDs: [2, 1, 0, 5, 4, 3, 8, 7, 6],
          cubeFaces: cubeFaces[i],
          facing: Facing.back,
        );
      } else {
        _setupSingleFace(
          cubeIDs: [18, 19, 20, 21, 22, 23, 24, 25, 26],
          cubeFaces: cubeFaces[i],
          facing: Facing.front,
        );
      }
    }
  }

  static String transformColorToString(Color color) {
    if (color == Colors.red) {
      return 'red';
    } else if (color == Colors.orange) {
      return 'orange';
    } else if (color == Colors.white) {
      return 'white';
    } else if (color == Colors.yellow) {
      return 'yellow';
    } else if (color == Colors.blue) {
      return 'blue';
    } else if (color == Colors.black) {
      return 'black';
    } else {
      return 'green';
    }
  }

  static Color _transformStringToColor(String color) {
    if (color == 'red') {
      return Colors.red;
    } else if (color == 'orange') {
      return Colors.orange;
    } else if (color == 'white') {
      return Colors.white;
    } else if (color == 'yellow') {
      return Colors.yellow;
    } else if (color == 'blue') {
      return Colors.blue;
    } else if (color == 'black') {
      return Colors.black;
    } else {
      return Colors.green;
    }
  }

  List<String> outputCubeState() {
    List<String> cubeStatus = [];
    for (Facing cubeFace in cubeFaces) {
      for (int cubeFaceID in cubeFaceIDs[cubeFace]!) {
        String cubeColor = transformColorToString(
            CubeState.cubeModels[cubeFaceID].component.cubeColor[cubeFace]!);
        cubeStatus.add(cubeColor);
      }
    }
    return cubeStatus;
  }

  void setCubeState({required List<String> cubeStatus}) {
    int index = 0;
    for (Facing cubeFace in cubeFaces) {
      List<SingleCubeComponentFaceModel> cubeFaceModes = [];
      for (int cubeFaceID in cubeFaceIDs[cubeFace]!) {
        SingleCubeComponentFaceModel cubeFaceModel =
            SingleCubeComponentFaceModel(
          id: cubeFaceID,
          color: _transformStringToColor(cubeStatus[index++]),
          isSelected: false,
        );
        cubeFaceModes.add(cubeFaceModel);
      }
      _setupSingleFace(
        cubeIDs: cubeFaceIDs[cubeFace]!,
        cubeFaces: cubeFaceModes,
        facing: cubeFace,
      );
    }
  }

  SingleCubeFace show2DFace({required Facing facing}) {
    List<SingleCubeComponentFaceModel> singleCubeComponentFaceModel = [];
    List<int> cubeFaceIndex = [];
    cubeFaceIndex.add(cubeFaceIDs[facing]![6]);
    cubeFaceIndex.add(cubeFaceIDs[facing]![7]);
    cubeFaceIndex.add(cubeFaceIDs[facing]![8]);
    cubeFaceIndex.add(cubeFaceIDs[facing]![3]);
    cubeFaceIndex.add(cubeFaceIDs[facing]![4]);
    cubeFaceIndex.add(cubeFaceIDs[facing]![5]);
    cubeFaceIndex.add(cubeFaceIDs[facing]![0]);
    cubeFaceIndex.add(cubeFaceIDs[facing]![1]);
    cubeFaceIndex.add(cubeFaceIDs[facing]![2]);
    for (int index in cubeFaceIndex) {
      singleCubeComponentFaceModel.add(
        SingleCubeComponentFaceModel(
          id: index,
          color: cubeModels[index].component.cubeColor[facing],
          isSelected: false,
        ),
      );
    }
    return SingleCubeFace(
        singleCubeComponentFaces: singleCubeComponentFaceModel);
  }

  void arrangeCube(String arrangeSide) {
    if (arrangeSide == 'right') {
      _arrangeCubeModel('right');
      _arrangedSingleCubeFace([2, 1, 5, 0, 4, 3]);
    } else {
      _arrangeCubeModel('left');
      _arrangedSingleCubeFace([3, 1, 0, 5, 4, 2]);
    }
    print('arrangeSide: $arrangeSide');
  }

  void _arrangeCubeModel(String arrangedSide) {
    List<int> list = [];
    if (arrangedSide == 'right') {
      for (int index in cubeArrangeX) {
        list.add(indexWithStack[index]);
      }
    } else if (arrangedSide == 'left') {
      for (int index in cubeArrangeXReverse) {
        list.add(indexWithStack[index]);
      }
    }
    indexWithStack = list;
  }

  void _arrangedSingleCubeFace(List<int> cubeFaceIndex) {
    for (SingleCubeModel cubeModel in cubeModels) {
      List<Widget> arrangedCubeFaces = [];
      for (int index in cubeFaceIndex) {
        arrangedCubeFaces.add(cubeModel.component.cubeFaces![index]);
      }
      cubeModel.component = CubeComponent(
        cubeColor: cubeModel.component.cubeColor,
        cubeFaces: arrangedCubeFaces,
      );
    }
  }

  void debugPrint({required int cubeModelIndex}) {
    print('cubeModelIndex: $cubeModelIndex');
    print('cubeModel: ${cubeModels[cubeModelIndex].component.cubeFaces}');
  }
}
