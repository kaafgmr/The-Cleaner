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
	float4 PreshaderBuffer[698 ];
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
	Material.PreshaderBuffer[1] = float4(0.000000,5.000000,1.761524,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(1803.800537,1803.800537,1803.800537,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(1803.800537,1803.800537,1803.800537,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(-1803.800537,-1803.800537,-1803.800537,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(-0.000554,-0.000554,-0.000554,0.371429);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.371429,0.371429,0.742858,-0.257142);//(Unknown)
	Material.PreshaderBuffer[7] = float4(6.000000,-5.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1024.000000,1024.000000,1024.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(1024.000000,1024.000000,1024.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(-1024.000000,-1024.000000,-1024.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(-0.000977,-0.000977,-0.000977,0.500000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.500000,0.500000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(2.000000,-1.000000,2.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(-1.000000,1.000000,0.400000,0.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(3.000000,-2.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(0.954252,1.000000,0.746338,0.000000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(0.954252,1.000000,0.746338,0.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(0.171875,0.170529,0.131592,1.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(6.285715,1.152286,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(1179.940918,1179.940918,1179.940918,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(1179.940918,1179.940918,1179.940918,0.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(-1179.940918,-1179.940918,-1179.940918,0.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(-0.000848,-0.000848,-0.000848,0.357143);//(Unknown)
	Material.PreshaderBuffer[29] = float4(0.357143,0.357143,0.714286,-0.285714);//(Unknown)
	Material.PreshaderBuffer[30] = float4(7.285715,-6.285715,0.000000,0.300000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(0.300000,0.300000,0.600000,-0.400000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[33] = float4(0.171875,0.170529,0.131592,1.000000);//(Unknown)
	Material.PreshaderBuffer[34] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[35] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[36] = float4(2389434429983708785147904.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[37] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[38] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[39] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[40] = float4(2387082470114310817316864.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[41] = float4(2383116420138463263719424.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[42] = float4(3509024685661995663360.000000,0.000000,120734089216.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[43] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[44] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[45] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[46] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[47] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[48] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[49] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[50] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[51] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[52] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[53] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[54] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[55] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[56] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[57] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[58] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[59] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[60] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[61] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[62] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[63] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[64] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[65] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[66] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[67] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[68] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
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
	MaterialFloat3 Local39 = (Local38 + saturate(MaterialFloat3(0.00000000,0.00000000,0.00000000)));
	MaterialFloat3 Local40 = saturate(Local39);
	FLWCVector3 Local41 = LWCMultiply(DERIV_BASE_VALUE(Local7), LWCPromote(Material.PreshaderBuffer[11].xyz));
	FLWCVector2 Local42 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local41)), LWCGetZ(DERIV_BASE_VALUE(Local41)));
	MaterialFloat2 Local43 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local42), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local44 = MaterialStoreTexCoordScale(Parameters, Local43, 2);
	MaterialFloat4 Local45 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local43));
	MaterialFloat Local46 = MaterialStoreTexSample(Parameters, Local45, 2);
	FLWCVector2 Local47 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local41)), LWCGetZ(DERIV_BASE_VALUE(Local41)));
	MaterialFloat2 Local48 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local47), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local49 = MaterialStoreTexCoordScale(Parameters, Local48, 2);
	MaterialFloat4 Local50 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local48));
	MaterialFloat Local51 = MaterialStoreTexSample(Parameters, Local50, 2);
	MaterialFloat3 Local52 = lerp(Local45.rgb,Local50.rgb,Local21.r.r);
	FLWCVector2 Local53 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local41)), LWCGetY(DERIV_BASE_VALUE(Local41)));
	MaterialFloat2 Local54 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local53), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local55 = MaterialStoreTexCoordScale(Parameters, Local54, 2);
	MaterialFloat4 Local56 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local54));
	MaterialFloat Local57 = MaterialStoreTexSample(Parameters, Local56, 2);
	MaterialFloat3 Local58 = lerp(Local52,Local56.rgb,Local30.r.r);
	MaterialFloat Local59 = (Local58.b + Material.PreshaderBuffer[12].w);
	MaterialFloat Local60 = lerp(Material.PreshaderBuffer[13].y,Material.PreshaderBuffer[13].x,Local59);
	MaterialFloat Local61 = saturate(Local60);
	MaterialFloat Local62 = saturate(Local61.r);
	MaterialFloat4 Local63 = Parameters.VertexColor;
	MaterialFloat Local64 = DERIV_BASE_VALUE(Local63).a;
	MaterialFloat Local65 = (Local58.b + DERIV_BASE_VALUE(Local64));
	MaterialFloat Local66 = saturate(Local65);
	MaterialFloat Local67 = (Local66 + Material.PreshaderBuffer[14].w);
	MaterialFloat Local68 = lerp(Material.PreshaderBuffer[15].y,Material.PreshaderBuffer[15].x,Local67);
	MaterialFloat Local69 = saturate(Local68);
	MaterialFloat Local70 = saturate(Local69.r);
	MaterialFloat3 Local71 = lerp(((MaterialFloat3)Local62),MaterialFloat3(0.00000000,0.00000000,0.00000000),Local70);
	MaterialFloat3 Local72 = saturate(Local71);
	MaterialFloat3 Local73 = (Local40 + Local72);
	MaterialFloat3 Local74 = saturate(Local73);
	MaterialFloat3 Local75 = lerp(Local2.rgb,Local6,Local74);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local75;


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
	MaterialFloat3 Local76 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[16].xyz,Material.PreshaderBuffer[15].z);
	MaterialFloat Local77 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 4);
	MaterialFloat4 Local78 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,sampler_Material_Texture2D_3,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local79 = MaterialStoreTexSample(Parameters, Local78, 4);
	MaterialFloat3 Local80 = (Local78.rgb * Material.PreshaderBuffer[18].xyz);
	MaterialFloat3 Local81 = (Local78.rgb * Material.PreshaderBuffer[20].xyz);
	MaterialFloat Local82 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 0);
	MaterialFloat4 Local83 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_4,sampler_Material_Texture2D_4,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local84 = MaterialStoreTexSample(Parameters, Local83, 0);
	MaterialFloat3 Local85 = lerp(Local80,Local81,Local83.b);
	MaterialFloat Local86 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 8);
	MaterialFloat4 Local87 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_5,sampler_Material_Texture2D_5,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local88 = MaterialStoreTexSample(Parameters, Local87, 8);
	MaterialFloat3 Local89 = (Local87.rgb * Material.PreshaderBuffer[22].xyz);
	MaterialFloat3 Local90 = lerp(Local85,Local89,Local74);
	FLWCVector3 Local91 = LWCMultiply(DERIV_BASE_VALUE(Local7), LWCPromote(Material.PreshaderBuffer[28].xyz));
	FLWCVector2 Local92 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local91)), LWCGetZ(DERIV_BASE_VALUE(Local91)));
	MaterialFloat2 Local93 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local92), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local94 = MaterialStoreTexCoordScale(Parameters, Local93, 2);
	MaterialFloat4 Local95 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local93));
	MaterialFloat Local96 = MaterialStoreTexSample(Parameters, Local95, 2);
	FLWCVector2 Local97 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local91)), LWCGetZ(DERIV_BASE_VALUE(Local91)));
	MaterialFloat2 Local98 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local97), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local99 = MaterialStoreTexCoordScale(Parameters, Local98, 2);
	MaterialFloat4 Local100 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local98));
	MaterialFloat Local101 = MaterialStoreTexSample(Parameters, Local100, 2);
	MaterialFloat3 Local102 = lerp(Local95.rgb,Local100.rgb,Local21.r.r);
	FLWCVector2 Local103 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local91)), LWCGetY(DERIV_BASE_VALUE(Local91)));
	MaterialFloat2 Local104 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local103), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local105 = MaterialStoreTexCoordScale(Parameters, Local104, 2);
	MaterialFloat4 Local106 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local104));
	MaterialFloat Local107 = MaterialStoreTexSample(Parameters, Local106, 2);
	MaterialFloat3 Local108 = lerp(Local102,Local106.rgb,Local30.r.r);
	MaterialFloat Local109 = (Local108.b + Material.PreshaderBuffer[29].w);
	MaterialFloat Local110 = lerp(Material.PreshaderBuffer[30].y,Material.PreshaderBuffer[30].x,Local109);
	MaterialFloat Local111 = saturate(Local110);
	MaterialFloat Local112 = saturate(Local111.r);
	MaterialFloat Local113 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 2);
	MaterialFloat4 Local114 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_2,sampler_Material_Texture2D_2,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local115 = MaterialStoreTexSample(Parameters, Local114, 2);
	MaterialFloat Local116 = (Local114.r + Material.PreshaderBuffer[31].w);
	MaterialFloat Local117 = lerp(Material.PreshaderBuffer[32].y,Material.PreshaderBuffer[32].x,Local116);
	MaterialFloat Local118 = saturate(Local117);
	MaterialFloat Local119 = (Local112 - Local118.r);
	MaterialFloat Local120 = saturate(Local119);
	MaterialFloat3 Local121 = lerp(Local90,Material.PreshaderBuffer[33].xyz,Local120);
	MaterialFloat Local122 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 7);
	MaterialFloat4 Local123 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_6,sampler_Material_Texture2D_6,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local124 = MaterialStoreTexSample(Parameters, Local123, 7);
	MaterialFloat4 Local125 = lerp(Local83.rgba,Local123.rgba,MaterialFloat4(MaterialFloat3(MaterialFloat2(Local74.x,Local74.x),Local74.x),Local74.x));
	MaterialFloat Local126 = (Local125.a * Material.PreshaderBuffer[33].w);
	MaterialFloat3 Local127 = lerp(MaterialFloat3(1.00000000,1.00000000,1.00000000),((MaterialFloat3)Local125.g),Material.PreshaderBuffer[34].x);

	PixelMaterialInputs.EmissiveColor = Local76;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local121;
	PixelMaterialInputs.Metallic = Local125.r;
	PixelMaterialInputs.Specular = 0.50000000;
	PixelMaterialInputs.Roughness = Local126;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local75;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local127;
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