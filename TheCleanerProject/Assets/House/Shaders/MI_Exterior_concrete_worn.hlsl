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
	float4 PreshaderBuffer[518 ];
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
	Material.PreshaderBuffer[1] = float4(0.000000,1.000000,0.500000,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(512.000000,512.000000,512.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(512.000000,512.000000,512.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(-512.000000,-512.000000,-512.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(-0.001953,-0.001953,-0.001953,0.238096);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.238096,0.238096,0.476192,-0.523808);//(Unknown)
	Material.PreshaderBuffer[7] = float4(2.000000,-1.000000,1.000000,0.700000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(716.799988,716.799988,716.799988,0.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(716.799988,716.799988,716.799988,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(-716.799988,-716.799988,-716.799988,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(-0.001395,-0.001395,-0.001395,0.328571);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.328571,0.328571,0.657142,-0.342858);//(Unknown)
	Material.PreshaderBuffer[13] = float4(2.000000,-1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.359375,0.339251,0.258648,0.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(0.359375,0.339251,0.258648,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(0.020833,0.018799,0.007412,1.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(0.571429,1.700000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(1740.800049,1740.800049,1740.800049,0.000000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(1740.800049,1740.800049,1740.800049,0.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(-1740.800049,-1740.800049,-1740.800049,0.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(-0.000574,-0.000574,-0.000574,0.228571);//(Unknown)
	Material.PreshaderBuffer[25] = float4(0.228571,0.228571,0.457142,-0.542858);//(Unknown)
	Material.PreshaderBuffer[26] = float4(1.571429,-0.571429,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.020833,0.018799,0.007412,1.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(2388927144521681772478464.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[33] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[34] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[35] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[36] = float4(3509024685661995663360.000000,0.000000,120734089216.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[37] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[38] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[39] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[40] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[41] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[42] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[43] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[44] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[45] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[46] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[47] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[48] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[49] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[50] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
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
	FLWCVector3 Local7 = GetWorldPosition_NoMaterialOffsets(Parameters);
	FLWCVector3 Local8 = LWCMultiply(DERIV_BASE_VALUE(Local7), LWCPromote(Material.PreshaderBuffer[5].xyz));
	FLWCVector2 Local9 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local8)), LWCGetZ(DERIV_BASE_VALUE(Local8)));
	MaterialFloat2 Local10 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local9), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local11 = MaterialStoreTexCoordScale(Parameters, Local10, 2);
	MaterialFloat4 Local12 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local10));
	MaterialFloat Local13 = MaterialStoreTexSample(Parameters, Local12, 2);
	FLWCVector2 Local14 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local8)), LWCGetZ(DERIV_BASE_VALUE(Local8)));
	MaterialFloat2 Local15 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local14), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local16 = MaterialStoreTexCoordScale(Parameters, Local15, 2);
	MaterialFloat4 Local17 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local15));
	MaterialFloat Local18 = MaterialStoreTexSample(Parameters, Local17, 2);
	MaterialFloat Local19 = abs(Parameters.TangentToWorld[2].r);
	MaterialFloat Local20 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local19);
	MaterialFloat Local21 = saturate(Local20);
	MaterialFloat3 Local22 = lerp(Local12.rgb,Local17.rgb,Local21.r.r);
	FLWCVector2 Local23 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local8)), LWCGetY(DERIV_BASE_VALUE(Local8)));
	MaterialFloat2 Local24 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local23), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local25 = MaterialStoreTexCoordScale(Parameters, Local24, 2);
	MaterialFloat4 Local26 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local24));
	MaterialFloat Local27 = MaterialStoreTexSample(Parameters, Local26, 2);
	MaterialFloat Local28 = abs(Parameters.TangentToWorld[2].b);
	MaterialFloat Local29 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local28);
	MaterialFloat Local30 = saturate(Local29);
	MaterialFloat3 Local31 = lerp(Local22,Local26.rgb,Local30.r.r);
	MaterialFloat Local32 = (Local31.b + Material.PreshaderBuffer[6].w);
	MaterialFloat Local33 = lerp(Material.PreshaderBuffer[7].y,Material.PreshaderBuffer[7].x,Local32);
	MaterialFloat Local34 = saturate(Local33);
	MaterialFloat Local35 = saturate(Local34.r);
	MaterialFloat3 Local36 = (saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000)) + ((MaterialFloat3)Local35));
	MaterialFloat3 Local37 = saturate(Local36);
	MaterialFloat3 Local38 = saturate(Local37);
	FLWCVector3 Local39 = LWCMultiply(DERIV_BASE_VALUE(Local7), LWCPromote(Material.PreshaderBuffer[11].xyz));
	FLWCVector2 Local40 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local39)), LWCGetZ(DERIV_BASE_VALUE(Local39)));
	MaterialFloat2 Local41 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local40), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local42 = MaterialStoreTexCoordScale(Parameters, Local41, 2);
	MaterialFloat4 Local43 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local41));
	MaterialFloat Local44 = MaterialStoreTexSample(Parameters, Local43, 2);
	FLWCVector2 Local45 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local39)), LWCGetZ(DERIV_BASE_VALUE(Local39)));
	MaterialFloat2 Local46 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local45), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local47 = MaterialStoreTexCoordScale(Parameters, Local46, 2);
	MaterialFloat4 Local48 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local46));
	MaterialFloat Local49 = MaterialStoreTexSample(Parameters, Local48, 2);
	MaterialFloat4 Local50 = lerp(MaterialFloat4(Local43.rgb,Local43.a),MaterialFloat4(Local48.rgb,Local48.a),Local21.r.r);
	FLWCVector2 Local51 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local39)), LWCGetY(DERIV_BASE_VALUE(Local39)));
	MaterialFloat2 Local52 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local51), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local53 = MaterialStoreTexCoordScale(Parameters, Local52, 2);
	MaterialFloat4 Local54 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local52));
	MaterialFloat Local55 = MaterialStoreTexSample(Parameters, Local54, 2);
	MaterialFloat4 Local56 = lerp(Local50,MaterialFloat4(Local54.rgb,Local54.a),Local30.r.r);
	MaterialFloat Local57 = (1.00000000 - Local56.a);
	MaterialFloat Local58 = (Local57 + Material.PreshaderBuffer[12].w);
	MaterialFloat Local59 = lerp(Material.PreshaderBuffer[13].y,Material.PreshaderBuffer[13].x,Local58);
	MaterialFloat Local60 = saturate(Local59);
	MaterialFloat Local61 = saturate(Local60.r);
	MaterialFloat3 Local62 = (Local38 + ((MaterialFloat3)Local61));
	MaterialFloat3 Local63 = saturate(Local62);
	MaterialFloat3 Local64 = saturate(Local63);
	MaterialFloat3 Local65 = lerp(Local2.rgb,Local6,Local64);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local65;


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
	MaterialFloat3 Local66 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[14].xyz,Material.PreshaderBuffer[13].z);
	MaterialFloat Local67 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 4);
	MaterialFloat4 Local68 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,sampler_Material_Texture2D_3,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local69 = MaterialStoreTexSample(Parameters, Local68, 4);
	MaterialFloat3 Local70 = (Local68.rgb * Material.PreshaderBuffer[16].xyz);
	MaterialFloat Local71 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 8);
	MaterialFloat4 Local72 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_4,sampler_Material_Texture2D_4,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local73 = MaterialStoreTexSample(Parameters, Local72, 8);
	MaterialFloat3 Local74 = (Local72.rgb * Material.PreshaderBuffer[18].xyz);
	MaterialFloat3 Local75 = lerp(Local70,Local74,Local64);
	FLWCVector3 Local76 = LWCMultiply(DERIV_BASE_VALUE(Local7), LWCPromote(Material.PreshaderBuffer[24].xyz));
	FLWCVector2 Local77 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local76)), LWCGetZ(DERIV_BASE_VALUE(Local76)));
	MaterialFloat2 Local78 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local77), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local79 = MaterialStoreTexCoordScale(Parameters, Local78, 2);
	MaterialFloat4 Local80 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local78));
	MaterialFloat Local81 = MaterialStoreTexSample(Parameters, Local80, 2);
	FLWCVector2 Local82 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local76)), LWCGetZ(DERIV_BASE_VALUE(Local76)));
	MaterialFloat2 Local83 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local82), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local84 = MaterialStoreTexCoordScale(Parameters, Local83, 2);
	MaterialFloat4 Local85 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local83));
	MaterialFloat Local86 = MaterialStoreTexSample(Parameters, Local85, 2);
	MaterialFloat3 Local87 = lerp(Local80.rgb,Local85.rgb,Local21.r.r);
	FLWCVector2 Local88 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local76)), LWCGetY(DERIV_BASE_VALUE(Local76)));
	MaterialFloat2 Local89 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local88), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local90 = MaterialStoreTexCoordScale(Parameters, Local89, 2);
	MaterialFloat4 Local91 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local89));
	MaterialFloat Local92 = MaterialStoreTexSample(Parameters, Local91, 2);
	MaterialFloat3 Local93 = lerp(Local87,Local91.rgb,Local30.r.r);
	MaterialFloat Local94 = (Local93.b + Material.PreshaderBuffer[25].w);
	MaterialFloat Local95 = lerp(Material.PreshaderBuffer[26].y,Material.PreshaderBuffer[26].x,Local94);
	MaterialFloat Local96 = saturate(Local95);
	MaterialFloat Local97 = saturate(Local96.r);
	MaterialFloat Local98 = saturate(Local97);
	MaterialFloat3 Local99 = lerp(Local75,Material.PreshaderBuffer[27].xyz,Local98);
	MaterialFloat Local100 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 0);
	MaterialFloat4 Local101 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_5,sampler_Material_Texture2D_5,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local102 = MaterialStoreTexSample(Parameters, Local101, 0);
	MaterialFloat Local103 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 7);
	MaterialFloat4 Local104 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_6,sampler_Material_Texture2D_6,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local105 = MaterialStoreTexSample(Parameters, Local104, 7);
	MaterialFloat4 Local106 = lerp(Local101.rgba,Local104.rgba,MaterialFloat4(MaterialFloat3(MaterialFloat2(Local64.x,Local64.x),Local64.x),Local64.x));
	MaterialFloat Local107 = (Local106.a * Material.PreshaderBuffer[27].w);
	MaterialFloat3 Local108 = lerp(MaterialFloat3(1.00000000,1.00000000,1.00000000),((MaterialFloat3)Local106.g),Material.PreshaderBuffer[28].x);

	PixelMaterialInputs.EmissiveColor = Local66;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local99;
	PixelMaterialInputs.Metallic = Local106.r;
	PixelMaterialInputs.Specular = 0.50000000;
	PixelMaterialInputs.Roughness = Local107;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local65;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local108;
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