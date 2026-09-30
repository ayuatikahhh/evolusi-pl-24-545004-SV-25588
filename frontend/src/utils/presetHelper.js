export function formatRatioLabel(preset) {
  return `${preset.food_pct}/${preset.operational_pct}/${preset.healing_pct}`
}

export function isValidPreset(preset) {
  return (preset.food_pct + preset.operational_pct + preset.healing_pct) === 100
}