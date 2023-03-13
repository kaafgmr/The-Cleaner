#define NUM_TEX_COORD_INTERPOLATORS 1
#define NUM_CUSTOM_VERTEX_INTERPOLATORS 0

struct Input
{
	//float3 Normal;
	float2 uv_MainTex : TEXCOORD0;
	float2 uv2_Material_Texture2D_0 : TEXCOORD1;
	float4 color : COLOR;
	float4 tangent;
	//float4 normal;
	float3 viewDir;
	float4 screenPos;
	float3 worldPos;
	//float3 worldNormal;
	float3 normal2;
};
struct SurfaceOutputStandard
{
	float3 Albedo;		// base (diffuse or specular) color
	float3 Normal;		// tangent space normal, if written
	half3 Emission;
	half Metallic;		// 0=non-metal, 1=metal
	// Smoothness is the user facing name, it should be perceptual smoothness but user should not have to deal with it.
	// Everywhere in the code you meet smoothness it is perceptual smoothness
	half Smoothness;	// 0=rough, 1=smooth
	half Occlusion;		// occlusion (default 1)
	float Alpha;		// alpha for transparencies
};

//#define Texture2D sampler2D
//#define TextureCube samplerCUBE
//#define SamplerState int

#define URP 1
#define UE5
//struct Material
//{
	//samplers start
SAMPLER( SamplerState_Linear_Repeat );
SAMPLER( SamplerState_Linear_Clamp );
TEXTURE2D(       Material_Texture2D_0 );
SAMPLER( sampler_Material_Texture2D_0);
TEXTURE2D(       Material_Texture2D_1 );
SAMPLER( sampler_Material_Texture2D_1);
TEXTURE2D(       Material_Texture2D_2 );
SAMPLER( sampler_Material_Texture2D_2);
TEXTURE2D(       Material_Texture2D_3 );
SAMPLER( sampler_Material_Texture2D_3);
TEXTURE2D(       Material_Texture2D_4 );
SAMPLER( sampler_Material_Texture2D_4);
TEXTURE2D(       Material_Texture2D_5 );
SAMPLER( sampler_Material_Texture2D_5);
TEXTURE2D(       Material_Texture2D_6 );
SAMPLER( sampler_Material_Texture2D_6);

//};

#ifdef UE5
	#define UE_LWC_RENDER_TILE_SIZE			2097152.0
	#define UE_LWC_RENDER_TILE_SIZE_SQRT	1448.15466
	#define UE_LWC_RENDER_TILE_SIZE_RSQRT	0.000690533954
	#define UE_LWC_RENDER_TILE_SIZE_RCP		4.76837158e-07
	#define UE_LWC_RENDER_TILE_SIZE_FMOD_PI		0.673652053
	#define UE_LWC_RENDER_TILE_SIZE_FMOD_2PI	0.673652053
	#define INVARIANT(X) X
	#define PI 					(3.1415926535897932)

	#include "LargeWorldCoordinates.hlsl"
#endif
struct MaterialStruct
{
	float4 PreshaderBuffer[278 ];
	float4 ScalarExpressions[11 ];
	float VTPackedPageTableUniform[ 4 ];
};
SamplerState View_MaterialTextureBilinearWrapedSampler;
SamplerState View_MaterialTextureBilinearClampedSampler;
struct ViewStruct
{
	float GameTime;
	float MaterialTextureMipBias;
	float4 PrimitiveSceneData[ 40 ];
	float2 TemporalAAParams;
	float2 ViewRectMin;
	float4 ViewSizeAndInvSize;
	float MaterialTextureDerivativeMultiply;
	uint StateFrameIndexMod8;
};
struct ResolvedViewStruct
{
	#ifdef UE5
		FLWCVector3 WorldCameraOrigin;
	#else
		float3 WorldCameraOrigin;
	#endif
	float4 ScreenPositionScaleBias;
	float4x4 TranslatedWorldToView;
	float4x4 TranslatedWorldToCameraView;
	float4x4 ViewToTranslatedWorld;
	float4x4 CameraViewToTranslatedWorld;
};
struct PrimitiveStruct
{
	float4x4 WorldToLocal;
	float4x4 LocalToWorld;
};

ViewStruct View;
ResolvedViewStruct ResolvedView;
PrimitiveStruct Primitive;
uniform float4 View_BufferSizeAndInvSize;
uniform SamplerState Material_Wrap_WorldGroupSettings;
uniform SamplerState Material_Clamp_WorldGroupSettings;

#include "UnrealCommon.cginc"

MaterialStruct Material;
void InitializeExpressions()
{
	Material.PreshaderBuffer[0] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[1] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.173506,0.192708,0.052177,1.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.000000,0.238476,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(244.199417,244.199417,244.199417,0.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(244.199417,244.199417,244.199417,0.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(-244.199417,-244.199417,-244.199417,0.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(-0.004095,-0.004095,-0.004095,0.204762);//(Unknown)
	Material.PreshaderBuffer[15] = float4(0.204762,0.204762,0.409524,-0.590476);//(Unknown)
	Material.PreshaderBuffer[16] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.173506,0.192708,0.052177,1.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(2383254770719016085356544.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(2383254770719016085356544.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(2384914977685649945001984.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(2386344600351362435252224.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(2384914977685649945001984.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(2386344600351362435252224.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(3509024685661995663360.000000,0.000000,120734089216.000000,0.000000);//(Unknown)
}void CalcPixelMaterialInputs(in out FMaterialPixelParameters Parameters, in out FPixelMaterialInputs PixelMaterialInputs)
{
	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	MaterialFloat2 Local0 = Parameters.TexCoords[0].xy;
	MaterialFloat Local1 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 1);
	MaterialFloat4 Local2 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_0,sampler_Material_Texture2D_0,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local3 = MaterialStoreTexSample(Parameters, Local2, 1);
	MaterialFloat4 Local4 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_1,sampler_Material_Texture2D_1,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local5 = MaterialStoreTexSample(Parameters, Local4, 1);
	MaterialFloat3 Local6 = lerp(Local4.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[1].x);
	MaterialFloat3 Local7 = lerp(Local2.rgb,Local6,saturate(saturate((saturate(saturate((saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000)) + saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000))))) + saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000))))));

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local7;


#if TEMPLATE_USES_STRATA
	Parameters.SharedLocalBases = StrataInitialiseSharedLocalBases();
#endif

	// Note that here MaterialNormal can be in world space or tangent space
	float3 MaterialNormal = GetMaterialNormal(Parameters, PixelMaterialInputs);

#if MATERIAL_TANGENTSPACENORMAL
#if SIMPLE_FORWARD_SHADING
	Parameters.WorldNormal = float3(0, 0, 1);
#endif

#if FEATURE_LEVEL >= FEATURE_LEVEL_SM4
	// Mobile will rely on only the final normalize for performance
	MaterialNormal = normalize(MaterialNormal);
#endif

	// normalizing after the tangent space to world space conversion improves quality with sheared bases (UV layout to WS causes shrearing)
	// use full precision normalize to avoid overflows
	Parameters.WorldNormal = TransformTangentNormalToWorld(Parameters.TangentToWorld, MaterialNormal);

#else //MATERIAL_TANGENTSPACENORMAL

	Parameters.WorldNormal = normalize(MaterialNormal);

#endif //MATERIAL_TANGENTSPACENORMAL

#if MATERIAL_TANGENTSPACENORMAL
	// flip the normal for backfaces being rendered with a two-sided material
	Parameters.WorldNormal *= Parameters.TwoSidedSign;
#endif

	Parameters.ReflectionVector = ReflectionAboutCustomWorldNormal(Parameters, Parameters.WorldNormal, false);

#if !PARTICLE_SPRITE_FACTORY
	Parameters.Particle.MotionBlurFade = 1.0f;
#endif // !PARTICLE_SPRITE_FACTORY

	// Now the rest of the inputs
	MaterialFloat3 Local8 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[2].xyz,Material.PreshaderBuffer[1].y);
	MaterialFloat Local9 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 4);
	MaterialFloat4 Local10 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_2,sampler_Material_Texture2D_2,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local11 = MaterialStoreTexSample(Parameters, Local10, 4);
	MaterialFloat3 Local12 = (Local10.rgb * Material.PreshaderBuffer[4].xyz);
	MaterialFloat3 Local13 = (Local10.rgb * Material.PreshaderBuffer[6].xyz);
	MaterialFloat Local14 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 0);
	MaterialFloat4 Local15 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,sampler_Material_Texture2D_3,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local16 = MaterialStoreTexSample(Parameters, Local15, 0);
	MaterialFloat3 Local17 = lerp(Local12,Local13,Local15.b);
	MaterialFloat Local18 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 8);
	MaterialFloat4 Local19 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_4,sampler_Material_Texture2D_4,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local20 = MaterialStoreTexSample(Parameters, Local19, 8);
	MaterialFloat3 Local21 = (Local19.rgb * Material.PreshaderBuffer[8].xyz);
	MaterialFloat3 Local22 = lerp(Local17,Local21,saturate(saturate((saturate(saturate((saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000)) + saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000))))) + saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000))))));
	FLWCVector3 Local23 = GetWorldPosition_NoMaterialOffsets(Parameters);
	FLWCVector3 Local24 = LWCMultiply(DERIV_BASE_VALUE(Local23), LWCPromote(Material.PreshaderBuffer[14].xyz));
	FLWCVector2 Local25 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local24)), LWCGetZ(DERIV_BASE_VALUE(Local24)));
	MaterialFloat2 Local26 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local25), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local27 = MaterialStoreTexCoordScale(Parameters, Local26, 2);
	MaterialFloat4 Local28 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(sampler_Material_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local26));
	MaterialFloat Local29 = MaterialStoreTexSample(Parameters, Local28, 2);
	FLWCVector2 Local30 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local24)), LWCGetZ(DERIV_BASE_VALUE(Local24)));
	MaterialFloat2 Local31 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local30), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local32 = MaterialStoreTexCoordScale(Parameters, Local31, 2);
	MaterialFloat4 Local33 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(sampler_Material_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local31));
	MaterialFloat Local34 = MaterialStoreTexSample(Parameters, Local33, 2);
	MaterialFloat Local35 = abs(Parameters.TangentToWorld[2].r);
	MaterialFloat Local36 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local35);
	MaterialFloat Local37 = saturate(Local36);
	MaterialFloat3 Local38 = lerp(Local28.rgb,Local33.rgb,Local37.r.r);
	FLWCVector2 Local39 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local24)), LWCGetY(DERIV_BASE_VALUE(Local24)));
	MaterialFloat2 Local40 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local39), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local41 = MaterialStoreTexCoordScale(Parameters, Local40, 2);
	MaterialFloat4 Local42 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(sampler_Material_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local40));
	MaterialFloat Local43 = MaterialStoreTexSample(Parameters, Local42, 2);
	MaterialFloat Local44 = abs(Parameters.TangentToWorld[2].b);
	MaterialFloat Local45 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local44);
	MaterialFloat Local46 = saturate(Local45);
	MaterialFloat3 Local47 = lerp(Local38,Local42.rgb,Local46.r.r);
	MaterialFloat Local48 = (Local47.b + Material.PreshaderBuffer[15].w);
	MaterialFloat Local49 = lerp(Material.PreshaderBuffer[16].y,Material.PreshaderBuffer[16].x,Local48);
	MaterialFloat Local50 = saturate(Local49);
	MaterialFloat Local51 = saturate(Local50.r);
	MaterialFloat Local52 = saturate(Local51);
	MaterialFloat3 Local53 = lerp(Local22,Material.PreshaderBuffer[17].xyz,Local52);
	MaterialFloat Local54 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 7);
	MaterialFloat4 Local55 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_6,sampler_Material_Texture2D_6,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local56 = MaterialStoreTexSample(Parameters, Local55, 7);
	MaterialFloat4 Local57 = lerp(Local15.rgba,Local55.rgba,MaterialFloat4(MaterialFloat3(MaterialFloat2(saturate(saturate((saturate(saturate((saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000)) + saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000))))) + saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000))))).x,saturate(saturate((saturate(saturate((saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000)) + saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000))))) + saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000))))).x),saturate(saturate((saturate(saturate((saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000)) + saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000))))) + saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000))))).x),saturate(saturate((saturate(saturate((saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000)) + saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000))))) + saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000))))).x));
	MaterialFloat Local58 = (Local57.a * Material.PreshaderBuffer[17].w);
	MaterialFloat3 Local59 = lerp(MaterialFloat3(1.00000000,1.00000000,1.00000000),((MaterialFloat3)Local57.g),Material.PreshaderBuffer[18].x);

	PixelMaterialInputs.EmissiveColor = Local8;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local53;
	PixelMaterialInputs.Metallic = Local57.r;
	PixelMaterialInputs.Specular = 0.50000000;
	PixelMaterialInputs.Roughness = Local58;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local7;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local59;
	PixelMaterialInputs.Refraction = 0;
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 1;
	PixelMaterialInputs.FrontMaterial = GetInitialisedStrataData();


#if MATERIAL_USES_ANISOTROPY
	Parameters.WorldTangent = CalculateAnisotropyTangent(Parameters, PixelMaterialInputs);
#else
	Parameters.WorldTangent = 0;
#endif
}

#define UnityObjectToWorldDir TransformObjectToWorld
void SurfaceReplacement( Input In, out SurfaceOutputStandard o )
{
	InitializeExpressions();

	float3 Z3 = float3( 0, 0, 0 );
	float4 Z4 = float4( 0, 0, 0, 0 );

	float3 UnrealWorldPos = float3( In.worldPos.x, In.worldPos.y, In.worldPos.z );

	float3 UnrealNormal = In.normal2;

	View_MaterialTextureBilinearWrapedSampler = SamplerState_Linear_Repeat;
	View_MaterialTextureBilinearClampedSampler = SamplerState_Linear_Clamp;

	Material_Wrap_WorldGroupSettings = SamplerState_Linear_Repeat;
	Material_Clamp_WorldGroupSettings = SamplerState_Linear_Clamp;

	FMaterialPixelParameters Parameters = (FMaterialPixelParameters)0;
#if NUM_TEX_COORD_INTERPOLATORS > 0			
	Parameters.TexCoords[ 0 ] = float2( In.uv_MainTex.x, In.uv_MainTex.y );
#endif
#if NUM_TEX_COORD_INTERPOLATORS > 1
	Parameters.TexCoords[ 1 ] = float2( In.uv2_Material_Texture2D_0.x, In.uv2_Material_Texture2D_0.y );
#endif
#if NUM_TEX_COORD_INTERPOLATORS > 2
	for( int i = 2; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
	{
		Parameters.TexCoords[ i ] = float2( In.uv_MainTex.x, In.uv_MainTex.y );
	}
#endif
	Parameters.VertexColor = In.color;
	Parameters.WorldNormal = UnrealNormal;
	Parameters.ReflectionVector = half3( 0, 0, 1 );
	//Parameters.CameraVector = normalize( _WorldSpaceCameraPos.xyz - UnrealWorldPos.xyz );
	Parameters.CameraVector = mul( ( float3x3 )unity_CameraToWorld, float3( 0, 0, 1 ) ) * -1;
	Parameters.LightVector = half3( 0, 0, 0 );
	float4 screenpos = In.screenPos;
	screenpos /= screenpos.w;
	//screenpos.y = 1 - screenpos.y;
	Parameters.SvPosition = float4( screenpos.x, screenpos.y, 0, 0 );
	Parameters.ScreenPosition = Parameters.SvPosition;

	Parameters.UnMirrored = 1;

	Parameters.TwoSidedSign = 1;


	float3 InWorldNormal = UnrealNormal;
	float4 InTangent = In.tangent;
	float4 tangentWorld = float4( UnityObjectToWorldDir( InTangent.xyz ), InTangent.w );
	tangentWorld.xyz = normalize( tangentWorld.xyz );
	//float3x3 tangentToWorld = CreateTangentToWorldPerVertex( InWorldNormal, tangentWorld.xyz, tangentWorld.w );
	Parameters.TangentToWorld = float3x3( Z3, Z3, InWorldNormal );// tangentToWorld;

	//WorldAlignedTexturing in UE relies on the fact that coords there are 100x larger, prepare values for that
	//but watch out for any computation that might get skewed as a side effect
	UnrealWorldPos = UnrealWorldPos * 100;
	UnrealWorldPos = UnrealWorldPos.xzy;
	Parameters.TangentToWorld[ 0 ] = Parameters.TangentToWorld[ 0 ].xzy;
	Parameters.TangentToWorld[ 1 ] = Parameters.TangentToWorld[ 1 ].xzy;
	Parameters.TangentToWorld[ 2 ] = Parameters.TangentToWorld[ 2 ].xzy;//WorldAligned texturing uses normals that think Z is up

	//Parameters.TangentToWorld = half3x3( float3( 1, 1, 1 ), float3( 1, 1, 1 ), UnrealNormal.xyz );
	Parameters.AbsoluteWorldPosition = UnrealWorldPos;
	Parameters.WorldPosition_CamRelative = UnrealWorldPos;
	Parameters.WorldPosition_NoOffsets = UnrealWorldPos;

	Parameters.WorldPosition_NoOffsets_CamRelative = Parameters.WorldPosition_CamRelative;
	Parameters.LightingPositionOffset = float3( 0, 0, 0 );

	Parameters.AOMaterialMask = 0;

	Parameters.Particle.RelativeTime = 0;
	Parameters.Particle.MotionBlurFade;
	Parameters.Particle.Random = 0;
	Parameters.Particle.Velocity = half4( 1, 1, 1, 1 );
	Parameters.Particle.Color = half4( 1, 1, 1, 1 );
	Parameters.Particle.TranslatedWorldPositionAndSize = float4( UnrealWorldPos, 0 );
	Parameters.Particle.MacroUV = half4( 0, 0, 1, 1 );
	Parameters.Particle.DynamicParameter = half4( 0, 0, 0, 0 );
	Parameters.Particle.LocalToWorld = float4x4( Z4, Z4, Z4, Z4 );
	Parameters.Particle.Size = float2( 1, 1 );
	Parameters.TexCoordScalesParams = float2( 0, 0 );
	Parameters.PrimitiveId = 0;
	Parameters.VirtualTextureFeedback = 0;

	FPixelMaterialInputs PixelMaterialInputs = (FPixelMaterialInputs)0;
	PixelMaterialInputs.Normal = float3( 0, 0, 1 );
	PixelMaterialInputs.ShadingModel = 0;
	PixelMaterialInputs.FrontMaterial = 0;

	//Extra
	View.GameTime = _Time.y;// _Time is (t/20, t, t*2, t*3)
	View.MaterialTextureMipBias = 0.0;
	View.TemporalAAParams = float2( 0, 0 );
	View.ViewRectMin = float2( 0, 0 );
	View.ViewSizeAndInvSize = View_BufferSizeAndInvSize;
	View.MaterialTextureDerivativeMultiply = 1.0f;
	View.StateFrameIndexMod8 = 0;

	for( int i2 = 0; i2 < 40; i2++ )
		View.PrimitiveSceneData[ i2 ] = float4( 0, 0, 0, 0 );

	uint PrimitiveBaseOffset = Parameters.PrimitiveId * PRIMITIVE_SCENE_DATA_STRIDE;
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 0 ] = unity_ObjectToWorld[ 0 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 1 ] = unity_ObjectToWorld[ 1 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 2 ] = unity_ObjectToWorld[ 2 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 3 ] = unity_ObjectToWorld[ 3 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 6 ] = unity_WorldToObject[ 0 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 7 ] = unity_WorldToObject[ 1 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 8 ] = unity_WorldToObject[ 2 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 9 ] = unity_WorldToObject[ 3 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 10 ] = unity_WorldToObject[ 0 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 11 ] = unity_WorldToObject[ 1 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 12 ] = unity_WorldToObject[ 2 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 13 ] = unity_WorldToObject[ 3 ];//PreviousLocalToWorld

	#ifdef UE5
		ResolvedView.WorldCameraOrigin = LWCPromote( _WorldSpaceCameraPos.xyz );
	#else
		ResolvedView.WorldCameraOrigin = _WorldSpaceCameraPos.xyz;
	#endif
	ResolvedView.ScreenPositionScaleBias = float4( 1, 1, 0, 0 );
	ResolvedView.TranslatedWorldToView = unity_MatrixV;
	ResolvedView.TranslatedWorldToCameraView = unity_MatrixV;
	ResolvedView.ViewToTranslatedWorld = unity_MatrixInvV;
	ResolvedView.CameraViewToTranslatedWorld = unity_MatrixInvV;
	Primitive.WorldToLocal = unity_WorldToObject;
	Primitive.LocalToWorld = unity_ObjectToWorld;
	CalcPixelMaterialInputs( Parameters, PixelMaterialInputs );

	#define HAS_WORLDSPACE_NORMAL 0
	#if HAS_WORLDSPACE_NORMAL
		PixelMaterialInputs.Normal = mul( PixelMaterialInputs.Normal, (MaterialFloat3x3)( transpose( Parameters.TangentToWorld ) ) );
	#endif

	o.Albedo = PixelMaterialInputs.BaseColor.rgb;
	o.Alpha = PixelMaterialInputs.Opacity;
	//if( PixelMaterialInputs.OpacityMask < 0.333 ) discard;

	o.Metallic = PixelMaterialInputs.Metallic;
	o.Smoothness = 1.0 - PixelMaterialInputs.Roughness;
	o.Normal = normalize( PixelMaterialInputs.Normal );
	o.Emission = PixelMaterialInputs.EmissiveColor.rgb;
	o.Occlusion = PixelMaterialInputs.AmbientOcclusion;

	//BLEND_ADDITIVE o.Alpha = ( o.Emission.r + o.Emission.g + o.Emission.b ) / 3;
}