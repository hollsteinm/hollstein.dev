import * as THREE from 'https://cdn.skypack.dev/three';
import * as CANNON from 'https://cdn.skypack.dev/cannon-es';
import cannonDebugger from 'https://cdn.skypack.dev/cannon-es-debugger';
import { OrbitControls } from 'https://cdn.skypack.dev/three/examples/jsm/controls/OrbitControls.js';
import { VRButton } from 'https://cdn.skypack.dev/three/examples/jsm/webxr/VRButton.js';
import { XRControllerModelFactory } from 'https://cdn.skypack.dev/three/examples/jsm/webxr/XRControllerModelFactory.js';

let container;
let camera, scene, renderer, phyworld;
let controller1, controller2;
let controllerGrip1, controllerGrip2;
let wallFloorMaterial, physicsMaterial;

let raycaster;

const intersected = [];
const tempMatrix = new THREE.Matrix4();

let controls, group;

init();

class SceneBody {
  constructor(node, body) {
    this.node = node;
    this.body = body;
    this.node.userData.sceneBody = this;
  }
  
  postPhysics() {
    this.node.position.copy(this.body.position);
    this.node.quaternion.copy(this.body.quaternion);
  }

  addToSceneWorld() {
    phyworld.addBody(this.body);
    scene.add(this.node);
  }
};

class InteractiveSceneBody extends SceneBody {
  constructor(node, body) {
    super(node, body)
    this.constructedBodyType = body.type;
    this.selected = false;
    group.attach(this.node);
  }

  postPhysics() {
    if (this.selected) {
      this.body.position.copy(this.node.position);
      this.body.quaternion.copy(this.node.quaternion);
    } else {
      super.postPhysics();
    }
  }

  onSelected() {
    this.selected = true;
    this.body.type = CANNON.Body.KINEMATIC;
    this.node.material.emissive.b = 1;
  }
  
  onDeselected() {
    this.selected = false;
    this.body.type = this.constructedBodyType;
    this.node.material.emissive.b = 0;
    group.attach(this.node);
  }
}

let allSceneBodies = [];

function createSceneBody(node, body) {
  let newSceneBody = new SceneBody(node, body);
  newSceneBody.addToSceneWorld();
  allSceneBodies.push(newSceneBody);
  return newSceneBody;
}

function createInteractiveSceneBody(node, body) {
  let newSceneBody = new InteractiveSceneBody(node, body);
  newSceneBody.addToSceneWorld();
  allSceneBodies.push(newSceneBody);
  return newSceneBody;
}

createFloorWallMaterials();
createFloor();
createCeiling();
createWalls();
createDesk();
createBook();

const timeStep = 1 / 60 // seconds
let lastCallTime = 0;
animate();

function createFloorWallMaterials() {
  physicsMaterial = new CANNON.Material('physics')
  const physics_physics = new CANNON.ContactMaterial(physicsMaterial, physicsMaterial, {
    friction: 0.0,
    restitution: 0.3,
  })

  // We must add the contact materials to the world
  phyworld.addContactMaterial(physics_physics)
  
  wallFloorMaterial = new THREE.MeshStandardMaterial( {
    color: 0x01535f,
    roughness: 1.0,
    metalness: 0.0
  } );
}

function createFloor() {
  const floorGeometry = new THREE.PlaneGeometry(10, 10);
  
  const floorMaterial = new THREE.MeshStandardMaterial( {
    color: 0x02b8a2,
    roughness: 1.0,
    metalness: 0.0
  } );
  
  const floor = new THREE.Mesh( floorGeometry, floorMaterial );
  floor.rotation.x = - Math.PI / 2;
  floor.receiveShadow = true;
  
  const groundShape = new CANNON.Plane()
  const groundBody = new CANNON.Body({ mass: 0, material: physicsMaterial })
  groundBody.addShape(groundShape)
  groundBody.quaternion.setFromEuler(-Math.PI / 2, 0, 0)
  
  createSceneBody(floor, groundBody)
}

function createCeiling() {
  const floorGeometry = new THREE.PlaneGeometry(10, 10);
  
  const ceilingMaterial = new THREE.MeshStandardMaterial( {
    color: 0xfdb232,
    roughness: 1.0,
    metalness: 0.0
  } );


  const ceiling = new THREE.Mesh( floorGeometry, ceilingMaterial );
  ceiling.rotation.x = Math.PI / 2;
  ceiling.receiveShadow = true;
  
  const groundShape = new CANNON.Plane()
  const groundBody = new CANNON.Body({ mass: 0, material: physicsMaterial })
  groundBody.addShape(groundShape)
  groundBody.quaternion.setFromEuler(Math.PI / 2, 0, 0)
  groundBody.position.set( 0, 5, 0);
  
  createSceneBody(ceiling, groundBody)
}

function createWalls() {
  const wallGeometry = new THREE.PlaneGeometry(5, 10);

  for (var idx = 0; idx < 4; ++idx) {
    const wall = new THREE.Mesh(wallGeometry.clone(), wallFloorMaterial);
    wall.receiveShadow = true;
    const wallShape = new CANNON.Box(new CANNON.Vec3(2.5, 5, 0.1))
    const wallBody = new CANNON.Body({ mass: 0, material: physicsMaterial })
    wallBody.addShape(wallShape)
    
    if (idx === 0) {
      wallBody.quaternion.setFromEuler(-Math.PI / 2, Math.PI / 2, 0)
      wallBody.position.set(-5, 2.5, 0);
    } else if (idx === 1) {
      wallBody.quaternion.setFromEuler(Math.PI / 2, -Math.PI / 2, 0)
      wallBody.position.set(5, 2.5, 0);
    } else if (idx === 2) {
      wallBody.quaternion.setFromEuler(Math.PI, 0, Math.PI / 2)
      wallBody.position.set(0, 2.5, 5);
    } else if (idx === 3) {
      wallBody.quaternion.setFromEuler(0, 0, Math.PI / 2)
      wallBody.position.set(0, 2.5, -5);
    }
    
    createSceneBody(wall, wallBody)
  }
}

function createDesk() {
  const deskBodyMaterial = new THREE.MeshStandardMaterial( {
    color: 0xeeeeee,
    roughness: 0.9,
    metalness: 0.3
  });
  
  const deskBodyGeometry = new THREE.BoxGeometry(3, 1, 1)
  const desk = new THREE.Mesh(deskBodyGeometry, deskBodyMaterial)
  
  const deskShape = new CANNON.Box(new CANNON.Vec3(1.5, 0.5, 0.5))
  const deskBody = new CANNON.Body({ mass: 0, material: physicsMaterial })
  
  deskBody.addShape(deskShape)
  deskBody.position.set(0, 0.5, 0);
  
  createSceneBody(desk, deskBody)
}

function createBook() {
  const bookMaterial = new THREE.MeshStandardMaterial( {
    color: 0xeeeeee,
    roughness: 1.0,
    metalness: 0.0
  });
  
  const mass = 3.18
  const size = 0.5
  const distance = size * 0.1

  const shape = new CANNON.Box(new CANNON.Vec3(size * 0.5, size * 0.5, 0.00625))
  const hingedBody = new CANNON.Body({ mass, type: CANNON.Body.DYNAMIC })
  hingedBody.addShape(shape)
  hingedBody.position.y = 3
  hingedBody.type = CANNON.Body.DYNAMIC;
  
  const hingedGeometry = new THREE.BoxGeometry(size, size, 0.0125)
  const hinged = new THREE.Mesh(hingedGeometry, bookMaterial)
  
  createInteractiveSceneBody(hinged, hingedBody)

  const dynamicBody = new CANNON.Body({ mass, type: CANNON.Body.DYNAMIC })
  dynamicBody.addShape(shape)
  dynamicBody.position.y = 3 + size;
  
  const hinged2 = new THREE.Mesh(hingedGeometry, bookMaterial)
  
  createInteractiveSceneBody(hinged2, dynamicBody)

  // Hinge it
  const constraint = new CANNON.HingeConstraint(dynamicBody, hingedBody, {
    pivotA: new CANNON.Vec3(-0.5, -size * 0.5 - distance, 0),
    axisA: new CANNON.Vec3(-1, 0, 0),
    pivotB: new CANNON.Vec3(-0.5, size * 0.5 + distance, 0),
    axisB: new CANNON.Vec3(-1, 0, 0),
    collideConnected: true
  })
  phyworld.addConstraint(constraint)
}

function init() {

  container = document.createElement( 'div' );
  document.body.appendChild( container );

  scene = new THREE.Scene();
  scene.background = new THREE.Color( 0x808080 );

  camera = new THREE.PerspectiveCamera( 50, window.innerWidth / window.innerHeight, 0.1, 25 );
  camera.position.set( 0, 1.6, 3 );

  controls = new OrbitControls( camera, container );
  controls.target.set( 0, 1.6, 0 );
  controls.update();

  scene.add( new THREE.HemisphereLight( 0x808080, 0x606060 ) );

  const light = new THREE.DirectionalLight( 0xffffff );
  light.position.set( 0, 6, 0 );
  light.castShadow = true;
  light.shadow.camera.top = 2;
  light.shadow.camera.bottom = - 2;
  light.shadow.camera.right = 2;
  light.shadow.camera.left = - 2;
  light.shadow.mapSize.set( 4096, 4096 );
  scene.add( light );

  //Create Renderer

  renderer = new THREE.WebGLRenderer( { antialias: true } );
  renderer.setPixelRatio( window.devicePixelRatio );
  renderer.setSize( window.innerWidth, window.innerHeight );
  renderer.outputEncoding =   THREE.sRGBEncoding;
  renderer.shadowMap.enabled = true;
  renderer.xr.enabled = true;
  container.appendChild( renderer.domElement );

  document.body.appendChild( VRButton.createButton( renderer ) );

  //Setup Controllers

  controller1 = renderer.xr.getController( 0 );
  controller1.addEventListener( 'selectstart', onSelectStart );
  controller1.addEventListener( 'selectend', onSelectEnd );
  scene.add( controller1 );

  controller2 = renderer.xr.getController( 1 );
  controller2.addEventListener( 'selectstart', onSelectStart );
  controller2.addEventListener( 'selectend', onSelectEnd );
  scene.add( controller2 );

  const controllerModelFactory = new XRControllerModelFactory();

  controllerGrip1 = renderer.xr.getControllerGrip( 0 );
  controllerGrip1.add( controllerModelFactory.createControllerModel( controllerGrip1 ) );
  scene.add( controllerGrip1 );

  controllerGrip2 = renderer.xr.getControllerGrip( 1 );
  controllerGrip2.add( controllerModelFactory.createControllerModel( controllerGrip2 ) );
  scene.add( controllerGrip2 );

  //Create RayCast Line

  const geometry = new THREE.BufferGeometry().setFromPoints( [ new THREE.Vector3( 0, 0, 0 ), new THREE.Vector3( 0, 0, - 1 ) ] );

  const line = new THREE.Line( geometry );
  line.name = 'line';
  line.scale.z = 5;

  controller1.add( line.clone() );
  controller2.add( line.clone() );

  raycaster = new THREE.Raycaster();
  
  // Portfolio Group
  group = new THREE.Group();
  scene.add( group );

  //Application Event Listener

  window.addEventListener('resize', onWindowResize);
  
  //Physics Setup
  phyworld = new CANNON.World({
    gravity: new CANNON.Vec3(0, -9.82, 0),
  });
  cannonDebugger(scene, phyworld.bodies, {});
}

function onWindowResize() {

  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();

  renderer.setSize( window.innerWidth, window.innerHeight );

}

function onSelectStart( event ) {

  const controller = event.target;

  const intersections = getIntersections( controller );

  if ( intersections.length > 0 ) {

    const intersection = intersections[ 0 ];

    const object = intersection.object;
    if (object.userData.sceneBody.onSelected) {
      object.userData.sceneBody.onSelected();
    }
    controller.attach( object );
    controller.userData.selected = object;
  }

}

function onSelectEnd( event ) {

  const controller = event.target;

  if ( controller.userData.selected !== undefined ) {

    const object = controller.userData.selected;
    if (object.userData.sceneBody.onDeselected) {
      object.userData.sceneBody.onDeselected();
    }
    controller.userData.selected = undefined;
  }


}

function getIntersections( controller ) {

  tempMatrix.identity().extractRotation( controller.matrixWorld );

  raycaster.ray.origin.setFromMatrixPosition( controller.matrixWorld );
  raycaster.ray.direction.set( 0, 0, - 1 ).applyMatrix4( tempMatrix );

  return raycaster.intersectObjects( group.children );

}

function intersectObjects( controller ) {

  // Do not highlight when already selected

  if ( controller.userData.selected !== undefined ) return;

  const line = controller.getObjectByName( 'line' );
  const intersections = getIntersections( controller );

  if ( intersections.length > 0 ) {

    const intersection = intersections[ 0 ];

    const object = intersection.object;
    object.material.emissive.r = 1;
    intersected.push( object );

    line.scale.z = intersection.distance;

  } else {

    line.scale.z = 5;

  }

}

function cleanIntersected() {

  while ( intersected.length ) {

    const object = intersected.pop();
    object.material.emissive.r = 0;

  }

}

function animate() {
  renderer.setAnimationLoop( render );
}

function render() {
  const time = performance.now() / 1000 // seconds
  if (lastCallTime === 0) {
    phyworld.step(timeStep)
  } else {
    const dt = time - lastCallTime
    phyworld.step(timeStep, dt)
  }
  for (var idx = 0; idx < allSceneBodies.length; ++idx) {
    allSceneBodies[idx].postPhysics();
  }
  
  cleanIntersected();

  intersectObjects( controller1 );
  intersectObjects( controller2 );

  renderer.render(scene, camera);
  
  lastCallTime = time
}
