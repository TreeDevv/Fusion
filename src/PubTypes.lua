--!strict

--[[
	Stores common public-facing type information for Fusion APIs.
]]

type Set<T> = {[T]: any}

--[[
	General use types
]]

-- A unique symbolic value.
export type Symbol = {
	type: "Symbol",
	name: string
}

-- Types that can be expressed as vectors of numbers, and so can be animated.
export type Animatable =
	number |
	CFrame |
	Color3 |
	ColorSequenceKeypoint |
	DateTime |
	NumberRange |
	NumberSequenceKeypoint |
	PhysicalProperties |
	Ray |
	Rect |
	Region3 |
	Region3int16 |
	UDim |
	UDim2 |
	Vector2 |
	Vector2int16 |
	Vector3 |
	Vector3int16

-- A task which can be accepted for cleanup.
export type Task =
	Instance |
	RBXScriptConnection |
	() -> () |
	{destroy: (any) -> ()} |
	{Destroy: (any) -> ()} |
	{Task}

-- Script-readable version information.
export type Version = {
	major: number,
	minor: number,
	isRelease: boolean
}
--[[
	Generic reactive graph types
]]

-- A graph object which can have dependents.
export type Dependency = {
	dependentSet: Set<Dependent>
}

-- A graph object which can have dependencies.
export type Dependent = {
	update: (Dependent) -> boolean,
	dependencySet: Set<Dependency>
}

-- An object which stores a piece of reactive state.
export type StateObject<T> = Dependency & {
	type: "State",
	kind: string
}

-- Either a constant value of type T, or a state object containing type T.
export type CanBeState<T> = StateObject<T> | T

-- Function signature for use callbacks.
export type Use = <T>(target: CanBeState<T>) -> T

--[[
	Specific reactive graph types
]]

-- A state object whose value can be set at any time by the user.
export type Value<T> = StateObject<T> & {
	kind: "State",
 	set: (Value<T>, newValue: any, force: boolean?) -> ()
}

-- A state object whose value is derived from other objects using a callback.
export type Computed<T> = StateObject<T> & Dependent & {
	kind: "Computed"
}

-- A state object whose value is derived from other objects using a callback.
export type ForPairs<KO, VO> = StateObject<{ [KO]: VO }> & Dependent & {
	kind: "ForPairs"
}
-- A state object whose value is derived from other objects using a callback.
export type ForKeys<KO, V> = StateObject<{ [KO]: V }> & Dependent & {
	kind: "ForKeys"
}
-- A state object whose value is derived from other objects using a callback.
export type ForValues<K, VO> = StateObject<{ [K]: VO }> & Dependent & {
	kind: "ForKeys"
}

-- A state object which follows another state object using tweens.
export type Tween<T> = StateObject<T> & Dependent & {
	kind: "Tween"
}

-- A state object which follows another state object using spring simulation.
export type Spring<T> = StateObject<T> & Dependent & {
	kind: "Spring",
	setPosition: (Spring<T>, newPosition: Animatable) -> (),
	setVelocity: (Spring<T>, newVelocity: Animatable) -> (),
	addVelocity: (Spring<T>, deltaVelocity: Animatable) -> ()
}

-- An object which can listen for updates on another state object.
export type Observer = Dependent & {
	kind: "Observer",
  	onChange: (Observer, callback: () -> ()) -> (() -> ())
}

--[[
	Instance related types
]]

-- Denotes children instances in an instance or component's property table.
export type SpecialKey = {
	type: "SpecialKey",
	kind: string,
	stage: "self" | "descendants" | "ancestor" | "observer",
	apply: (SpecialKey, value: any, applyTo: Instance, cleanupTasks: {Task}) -> ()
}

-- A collection of instances that may be parented to another instance.
export type Children = Instance | StateObject<Children> | {[any]: Children}

-- A table that defines an instance's properties, handlers and children.
export type PropertyTable = {[string | SpecialKey]: any}

export type InstanceClass = 'Accessory'|
'Accoutrement'|
'AlignOrientation'|
'AlignPosition'|
'AngularVelocity'|
'Animation'|
'AnimationController'|
'ArcHandles'|
'Atmosphere'|
'Backpack'|
'BallSocketConstraint'|
'Beam'|
'BillboardGui'|
'BinaryStringValue'|
'BindableEvent'|
'BindableFunction'|
'BlockMesh'|
'BloomEffect'|
'BlurEffect'|
'BodyAngularVelocity'|
'BodyColors'|
'BodyForce'|
'BodyGyro'|
'BodyPosition'|
'BodyThrust'|
'BodyVelocity'|
'BoolValue'|
'BoxHandleAdornment'|
'BrickColorValue'|
'Camera'|
'CFrameValue'|
'CharacterMesh'|
'ChorusSoundEffect'|
'ClickDetector'|
'Color3Value'|
'ColorCorrectionEffect'|
'CompressorSoundEffect'|
'ConeHandleAdornment'|
'Configuration'|
'CornerWedgePart'|
'CylinderHandleAdornment'|
'CylindricalConstraint'|
'Decal'|
'DepthOfFieldEffect'|
'Dialog'|
'DialogChoice'|
'DistortionSoundEffect'|
'EchoSoundEffect'|
'EqualizerSoundEffect'|
'Explosion'|
'FileMesh'|
'Fire'|
'FlangeSoundEffect'|
'Folder'|
'ForceField'|
'Frame'|
'Handles'|
'HingeConstraint'|
'Humanoid'|
'HumanoidController'|
'HumanoidDescription'|
'ImageButton'|
'ImageHandleAdornment'|
'ImageLabel'|
'IntValue'|
'Keyframe'|
'KeyframeMarker'|
'KeyframeSequence'|
'LineForce'|
'LineHandleAdornment'|
'LocalizationTable'|
'LocalScript'|
'ManualGlue'|
'ManualWeld'|
'MeshPart'|
'Model'|
'ModuleScript'|
'Motor'|
'Motor6D'|
'NegateOperation'|
'NoCollisionConstraint'|
'NumberValue'|
'ObjectValue'|
'Pants'|
'Part'|
'ParticleEmitter'|
'PartOperation'|
'PartOperationAsset'|
'PitchShiftSoundEffect'|
'PointLight'|
'Pose'|
'PrismaticConstraint'|
'ProximityPrompt'|
'RayValue'|
'ReflectionMetadata'|
'ReflectionMetadataCallbacks'|
'ReflectionMetadataClass'|
'ReflectionMetadataClasses'|
'ReflectionMetadataEnum'|
'ReflectionMetadataEnumItem'|
'ReflectionMetadataEnums'|
'ReflectionMetadataEvents'|
'ReflectionMetadataFunctions'|
'ReflectionMetadataMember'|
'ReflectionMetadataProperties'|
'ReflectionMetadataYieldFunctions'|
'RemoteEvent'|
'RemoteFunction'|
'RenderingTest'|
'ReverbSoundEffect'|
'RocketPropulsion'|
'RodConstraint'|
'RopeConstraint'|
'Rotate'|
'RotateP'|
'RotateV'|
'ScreenGui'|
'Script'|
'ScrollingFrame'|
'Seat'|
'SelectionBox'|
'SelectionSphere'|
'Shirt'|
'ShirtGraphic'|
'SkateboardController'|
'Sky'|
'Smoke'|
'Snap'|
'Sound'|
'SoundGroup'|
'Sparkles'|
'SpawnLocation'|
'SpecialMesh'|
'SphereHandleAdornment'|
'SpotLight'|
'SpringConstraint'|
'StandalonePluginScripts'|
'StarterGear'|
'StringValue'|
'SunRaysEffect'|
'SurfaceAppearance'|
'SurfaceGui'|
'SurfaceLight'|
'SurfaceSelection'|
'Team'|
'TerrainRegion'|
'TextBox'|
'TextButton'|
'TextLabel'|
'Texture'|
'Tool'|
'Torque'|
'Trail'|
'TremoloSoundEffect'|
'TrussPart'|
'Tween'|
'UIAspectRatioConstraint'|
'UICorner'|
'UIGradient'|
'UIGridLayout'|
'UIListLayout'|
'UIPadding'|
'UIPageLayout'|
'UIScale'|
'UISizeConstraint'|
'UITableLayout'|
'UITextSizeConstraint'|
'UnionOperation'|
'Vector3Value'|
'VectorForce'|
'VehicleController'|
'VehicleSeat'|
'VelocityMotor'|
'VideoFrame'|
'ViewportFrame'|
'WedgePart'|
'Weld'|
'WeldConstraint'

return nil