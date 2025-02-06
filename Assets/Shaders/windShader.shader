// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "windShader"
{
	Properties
	{
		_WindTexture("Wind Texture", 2D) = "white" {}
		[Toggle]_TimeManualToggle("Time/Manual Toggle", Float) = 0
		_TimeScale("Time Scale", Float) = 1
		_Color0("Color 0", Color) = (0.7411765,0.9921569,0.909804,1)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.5
		#define ASE_VERSION 19801
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv2_texcoord2;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Color0;
		uniform sampler2D _WindTexture;
		uniform float _TimeManualToggle;
		uniform float _TimeScale;


		struct Gradient
		{
			int type;
			int colorsLength;
			int alphasLength;
			float4 colors[8];
			float2 alphas[8];
		};


		Gradient NewGradient(int type, int colorsLength, int alphasLength, 
		float4 colors0, float4 colors1, float4 colors2, float4 colors3, float4 colors4, float4 colors5, float4 colors6, float4 colors7,
		float2 alphas0, float2 alphas1, float2 alphas2, float2 alphas3, float2 alphas4, float2 alphas5, float2 alphas6, float2 alphas7)
		{
			Gradient g;
			g.type = type;
			g.colorsLength = colorsLength;
			g.alphasLength = alphasLength;
			g.colors[ 0 ] = colors0;
			g.colors[ 1 ] = colors1;
			g.colors[ 2 ] = colors2;
			g.colors[ 3 ] = colors3;
			g.colors[ 4 ] = colors4;
			g.colors[ 5 ] = colors5;
			g.colors[ 6 ] = colors6;
			g.colors[ 7 ] = colors7;
			g.alphas[ 0 ] = alphas0;
			g.alphas[ 1 ] = alphas1;
			g.alphas[ 2 ] = alphas2;
			g.alphas[ 3 ] = alphas3;
			g.alphas[ 4 ] = alphas4;
			g.alphas[ 5 ] = alphas5;
			g.alphas[ 6 ] = alphas6;
			g.alphas[ 7 ] = alphas7;
			return g;
		}


		float4 SampleGradient( Gradient gradient, float time )
		{
			float3 color = gradient.colors[0].rgb;
			UNITY_UNROLL
			for (int c = 1; c < 8; c++)
			{
			float colorPos = saturate((time - gradient.colors[c-1].w) / ( 0.00001 + (gradient.colors[c].w - gradient.colors[c-1].w)) * step(c, (float)gradient.colorsLength-1));
			color = lerp(color, gradient.colors[c].rgb, lerp(colorPos, step(0.01, colorPos), gradient.type));
			}
			#ifndef UNITY_COLORSPACE_GAMMA
			color = half3(GammaToLinearSpaceExact(color.r), GammaToLinearSpaceExact(color.g), GammaToLinearSpaceExact(color.b));
			#endif
			float alpha = gradient.alphas[0].x;
			UNITY_UNROLL
			for (int a = 1; a < 8; a++)
			{
			float alphaPos = saturate((time - gradient.alphas[a-1].y) / ( 0.00001 + (gradient.alphas[a].y - gradient.alphas[a-1].y)) * step(a, (float)gradient.alphasLength-1));
			alpha = lerp(alpha, gradient.alphas[a].x, lerp(alphaPos, step(0.01, alphaPos), gradient.type));
			}
			return float4(color, alpha);
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			Gradient gradient55 = NewGradient( 0, 3, 5, float4( 1, 1, 1, 0 ), float4( 1, 1, 1, 0.5000076 ), float4( 1, 1, 1, 1 ), 0, 0, 0, 0, 0, float2( 0, 0 ), float2( 0.4352875, 0.2 ), float2( 1, 0.5000076 ), float2( 0.8706015, 0.8 ), float2( 0, 1 ), 0, 0, 0 );
			float mulTime3 = _Time.y * _TimeScale;
			float4 appendResult7 = (float4(i.uv_texcoord.x , ( i.uv_texcoord.y + (( _TimeManualToggle )?( i.uv2_texcoord2.x ):( mulTime3 )) ) , 0.0 , 0.0));
			float4 temp_output_54_0 = ( ( _Color0 * SampleGradient( gradient55, i.uv_texcoord.y ) ) * float4( tex2D( _WindTexture, appendResult7.xy, ddx( i.uv_texcoord ), ddy( i.uv_texcoord ) ).rgb , 0.0 ) );
			o.Emission = temp_output_54_0.rgb;
			o.Alpha = ( temp_output_54_0 * i.vertexColor ).r;
		}

		ENDCG
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.RangedFloatNode;50;-2160,-128;Inherit;False;Property;_TimeScale;Time Scale;2;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;3;-2000,-128;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1;-1968,256;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;20;-1664,96;Inherit;False;Property;_TimeManualToggle;Time/Manual Toggle;1;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;62;-1648,-144;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;2;-1360,64;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GradientNode;55;-1424,-352;Inherit;False;0;3;5;1,1,1,0;1,1,1,0.5000076;1,1,1,1;0,0;0.4352875,0.2;1,0.5000076;0.8706015,0.8;0,1;0;1;OBJECT;0
Node;AmplifyShaderEditor.DdyOpNode;6;-1024,304;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DdxOpNode;5;-1024,240;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-1120,32;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;61;-1104,-576;Inherit;False;Property;_Color0;Color 0;4;0;Create;True;0;0;0;False;0;False;0.7411765,0.9921569,0.909804,1;0.7411765,0.9921569,0.909804,1;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.GradientSampleNode;56;-1152,-352;Inherit;True;2;0;OBJECT;;False;1;FLOAT;0.2;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-864,32;Inherit;True;Property;_WindTexture;Wind Texture;0;0;Create;True;0;0;0;False;0;False;-1;434abb688ac0dac47a27a918861cfd5a;434abb688ac0dac47a27a918861cfd5a;True;0;False;white;Auto;False;Object;-1;Derivative;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-765.5097,-459.9857;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;57;-736,288;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-496,-192;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-256,160;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2000,112;Inherit;False;Property;_ManualWindPanning;Manual Wind Panning;3;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-16,-96;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Unlit;windShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;50;0
WireConnection;20;0;3;0
WireConnection;20;1;1;1
WireConnection;2;0;62;2
WireConnection;2;1;20;0
WireConnection;6;0;62;0
WireConnection;5;0;62;0
WireConnection;7;0;62;0
WireConnection;7;1;2;0
WireConnection;56;0;55;0
WireConnection;56;1;62;2
WireConnection;4;1;7;0
WireConnection;4;3;5;0
WireConnection;4;4;6;0
WireConnection;60;0;61;0
WireConnection;60;1;56;0
WireConnection;54;0;60;0
WireConnection;54;1;4;5
WireConnection;58;0;54;0
WireConnection;58;1;57;0
WireConnection;0;2;54;0
WireConnection;0;9;58;0
ASEEND*/
//CHKSM=AB28E58AC612FBC2AC24A2037F83D8C0AF5DFBF7