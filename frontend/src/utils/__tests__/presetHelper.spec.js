import { describe, it, expect } from 'vitest'
import { formatRatioLabel, isValidPreset } from '../presetHelper'

describe('formatRatioLabel', () => {
  it('menyusun label rasio food/operational/healing dengan benar', () => {
    const preset = { food_pct: 50, operational_pct: 30, healing_pct: 20 }
    expect(formatRatioLabel(preset)).toBe('50/30/20')
  })
})

describe('isValidPreset', () => {
  it('mengembalikan true ketika total persentase tepat 100', () => {
    const preset = { food_pct: 40, operational_pct: 40, healing_pct: 20 }
    expect(isValidPreset(preset)).toBe(true)
  })

  it('mengembalikan false ketika total persentase bukan 100', () => {
    const preset = { food_pct: 50, operational_pct: 40, healing_pct: 20 } // total 110
    expect(isValidPreset(preset)).toBe(false)
  })
})