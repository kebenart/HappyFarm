class_name RainPanel
extends CanvasLayer

@onready var rain_particles: GPUParticles2D = $RainParticles
@onready var rain_bloom_particles: GPUParticles2D = $RainBloomParticles

# 后续拆分,制作整体的天气系统, 例如天气管理器, 定义枚举, 
func _ready() -> void:
	rain_particles.emitting = false
	rain_bloom_particles.emitting = false
	WeatherManager.open_rain.connect(on_open_rain)
	WeatherManager.close_rain.connect(on_close_rain)


func on_open_rain() -> void:
	rain_particles.emitting = true
	rain_bloom_particles.emitting = true


func on_close_rain() -> void:
	rain_particles.emitting = false
	rain_bloom_particles.emitting = false
