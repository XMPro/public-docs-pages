# Phase 6: Migrate Use Cases Content
function Execute-Phase6 {
    Write-Log "Executing Phase 6: Migrate Use Cases Content" -Level "INFO"
    
    # Define the GitBook use cases directory
    $gitbookUseCasesDir = Join-Path $baseDir "../docs-gitbook/docs/resources/faqs/external-content/use-cases"
    
    # Check if the GitBook use cases directory exists
    if (-not (Test-Path $gitbookUseCasesDir)) {
        Write-Log "GitBook use cases directory not found: $gitbookUseCasesDir" -Level "ERROR"
        return $false
    }
    
    # Define the DocFX use cases directory
    $docfxUseCasesDir = Join-Path $externalContentDir "use-cases"
    
    # Get all markdown files in the GitBook use cases directory
    $useCaseFiles = Get-ChildItem -Path $gitbookUseCasesDir -Filter "*.md" -Recurse | Where-Object { $_.Name -ne "README.md" }
    
    # Initialize a counter for migrated use cases
    $migratedUseCasesCount = 0
    $totalUseCasesCount = $useCaseFiles.Count
    
    # Initialize the TOC content for use cases
    $useCasesTocContent = @"
- name: Use Cases
  href: index.md
"@
    
    # Process each use case file
    foreach ($useCaseFile in $useCaseFiles) {
        # Skip if already migrated
        if ($script:state.use_cases_migrated -contains $useCaseFile.Name) {
            Write-Log "Use case already migrated: $($useCaseFile.Name)" -Level "INFO"
            continue
        }
        
        Write-Log "Migrating use case: $($useCaseFile.Name)" -Level "INFO"
        
        # Read the use case content
        $useCaseContent = Get-Content -Path $useCaseFile.FullName -Raw
        
        # Extract the title from the first line (assuming it's a markdown heading)
        $titleMatch = [regex]::Match($useCaseContent, "^#\s+(.+)$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
        $useCaseTitle = if ($titleMatch.Success) { $titleMatch.Groups[1].Value } else { [System.IO.Path]::GetFileNameWithoutExtension($useCaseFile.Name) }
        
        # Create a sanitized filename
        $sanitizedFileName = [System.IO.Path]::GetFileNameWithoutExtension($useCaseFile.Name) + ".md"
        
        # Define the DocFX use case file path
        $docfxUseCasePath = Join-Path $docfxUseCasesDir $sanitizedFileName
        
        # Write the use case content to the DocFX file
        Set-Content -Path $docfxUseCasePath -Value $useCaseContent
        
        # Add to the TOC content
        $useCasesTocContent += @"

- name: $useCaseTitle
  href: $sanitizedFileName
"@
        
        # Add to the migrated use cases list
        $script:state.use_cases_migrated += $useCaseFile.Name
        $migratedUseCasesCount++
        
        # Save state after each use case to ensure progress is not lost
        Save-State
    }
    
    # Update the use cases TOC file
    $useCasesTocPath = Join-Path $docfxUseCasesDir "toc.yml"
    Set-Content -Path $useCasesTocPath -Value $useCasesTocContent
    
    # Update the use cases index file to include links to the use cases
    $useCasesIndexPath = Join-Path $docfxUseCasesDir "index.md"
    $useCasesIndexContent = @"
# Use Cases

Real-world use cases demonstrating how XMPro is used in various industries.

## Use Cases

"@
    
    # Add links to each use case
    foreach ($useCaseFile in $useCaseFiles) {
        $sanitizedFileName = [System.IO.Path]::GetFileNameWithoutExtension($useCaseFile.Name) + ".md"
        $useCaseContent = Get-Content -Path $useCaseFile.FullName -Raw
        $titleMatch = [regex]::Match($useCaseContent, "^#\s+(.+)$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
        $useCaseTitle = if ($titleMatch.Success) { $titleMatch.Groups[1].Value } else { [System.IO.Path]::GetFileNameWithoutExtension($useCaseFile.Name) }
        
        $useCasesIndexContent += @"

- [$useCaseTitle]($sanitizedFileName)
"@
    }
    
    # Write the updated index file
    Set-Content -Path $useCasesIndexPath -Value $useCasesIndexContent
    
    # Log the migration results
    Write-Log "Use cases migration completed: $migratedUseCasesCount of $totalUseCasesCount use cases migrated" -Level "SUCCESS"
    
    # Check if all use cases were migrated
    $allUseCasesMigrated = $migratedUseCasesCount -eq $totalUseCasesCount
    
    if ($allUseCasesMigrated) {
        Write-Log "All use cases migrated successfully" -Level "SUCCESS"
        $script:state.phase = 6
        $script:state.completed = $true
        Save-State
        return $true
    }
    else {
        Write-Log "Some use cases could not be migrated" -Level "WARNING"
        return $false
    }
}

# Main execution
function Start-Migration {
    Write-Log "Starting navigation migration script" -Level "INFO"
    
    # Initialize state
    Initialize-State
    
    # Execute phases based on current state
    switch ($script:state.phase) {
        0 {
            Write-Log "Starting migration from the beginning..." -Level "INFO"
            $script:state.phase = 1
            $script:state.completed = $false
            Save-State
            if (Execute-Phase1) {
                Write-Log "Phase 1 completed successfully. Moving to Phase 2." -Level "SUCCESS"
                $script:state.phase = 2
                $script:state.completed = $false
                Save-State
                if (Execute-Phase2) {
                    Write-Log "Phase 2 completed successfully. Moving to Phase 3." -Level "SUCCESS"
                    $script:state.phase = 3
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase3) {
                        Write-Log "Phase 3 completed successfully. Moving to Phase 4." -Level "SUCCESS"
                        $script:state.phase = 4
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase4) {
                            Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                            $script:state.phase = 5
                            $script:state.completed = $false
                            Save-State
                            if (Execute-Phase5) {
                                Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                                $script:state.phase = 6
                                $script:state.completed = $false
                                Save-State
                                if (Execute-Phase6) {
                                    Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                                    Write-Log "Use cases content migration complete." -Level "SUCCESS"
                                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                                }
                            }
                        }
                    }
                }
            }
        }
        1 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 1: Create Base Directory Structure..." -Level "INFO"
                if (Execute-Phase1) {
                    Write-Log "Phase 1 completed successfully. Moving to Phase 2." -Level "SUCCESS"
                    $script:state.phase = 2
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase2) {
                        Write-Log "Phase 2 completed successfully. Moving to Phase 3." -Level "SUCCESS"
                        $script:state.phase = 3
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase3) {
                            Write-Log "Phase 3 completed successfully. Moving to Phase 4." -Level "SUCCESS"
                            $script:state.phase = 4
                            $script:state.completed = $false
                            Save-State
                            if (Execute-Phase4) {
                                Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                                $script:state.phase = 5
                                $script:state.completed = $false
                                Save-State
                                if (Execute-Phase5) {
                                    Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                                    $script:state.phase = 6
                                    $script:state.completed = $false
                                    Save-State
                                    if (Execute-Phase6) {
                                        Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                                        Write-Log "Use cases content migration complete." -Level "SUCCESS"
                                        Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                                    }
                                }
                            }
                        }
                    }
                }
            }
            else {
                Write-Log "Phase 1 already completed. Moving to Phase 2..." -Level "INFO"
                $script:state.phase = 2
                $script:state.completed = $false
                Save-State
                if (Execute-Phase2) {
                    Write-Log "Phase 2 completed successfully. Moving to Phase 3." -Level "SUCCESS"
                    $script:state.phase = 3
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase3) {
                        Write-Log "Phase 3 completed successfully. Moving to Phase 4." -Level "SUCCESS"
                        $script:state.phase = 4
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase4) {
                            Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                            $script:state.phase = 5
                            $script:state.completed = $false
                            Save-State
                            if (Execute-Phase5) {
                                Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                                $script:state.phase = 6
                                $script:state.completed = $false
                                Save-State
                                if (Execute-Phase6) {
                                    Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                                    Write-Log "Use cases content migration complete." -Level "SUCCESS"
                                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                                }
                            }
                        }
                    }
                }
            }
        }
        2 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 2: Create TOC Files for Main Sections..." -Level "INFO"
                if (Execute-Phase2) {
                    Write-Log "Phase 2 completed successfully. Moving to Phase 3." -Level "SUCCESS"
                    $script:state.phase = 3
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase3) {
                        Write-Log "Phase 3 completed successfully. Moving to Phase 4." -Level "SUCCESS"
                        $script:state.phase = 4
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase4) {
                            Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                            $script:state.phase = 5
                            $script:state.completed = $false
                            Save-State
                            if (Execute-Phase5) {
                                Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                                $script:state.phase = 6
                                $script:state.completed = $false
                                Save-State
                                if (Execute-Phase6) {
                                    Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                                    Write-Log "Use cases content migration complete." -Level "SUCCESS"
                                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                                }
                            }
                        }
                    }
                }
            }
            else {
                Write-Log "Phase 2 already completed. Moving to Phase 3..." -Level "INFO"
                $script:state.phase = 3
                $script:state.completed = $false
                Save-State
                if (Execute-Phase3) {
                    Write-Log "Phase 3 completed successfully. Moving to Phase 4." -Level "SUCCESS"
                    $script:state.phase = 4
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase4) {
                        Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                        $script:state.phase = 5
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase5) {
                            Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                            $script:state.phase = 6
                            $script:state.completed = $false
                            Save-State
                            if (Execute-Phase6) {
                                Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                                Write-Log "Use cases content migration complete." -Level "SUCCESS"
                                Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                            }
                        }
                    }
                }
            }
        }
        3 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 3: Create Index Files for Main Sections..." -Level "INFO"
                if (Execute-Phase3) {
                    Write-Log "Phase 3 completed successfully. Moving to Phase 4." -Level "SUCCESS"
                    $script:state.phase = 4
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase4) {
                        Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                        $script:state.phase = 5
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase5) {
                            Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                            $script:state.phase = 6
                            $script:state.completed = $false
                            Save-State
                            if (Execute-Phase6) {
                                Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                                Write-Log "Use cases content migration complete." -Level "SUCCESS"
                                Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                            }
                        }
                    }
                }
            }
            else {
                Write-Log "Phase 3 already completed. Moving to Phase 4..." -Level "INFO"
                $script:state.phase = 4
                $script:state.completed = $false
                Save-State
                if (Execute-Phase4) {
                    Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                    $script:state.phase = 5
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase5) {
                        Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                        $script:state.phase = 6
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase6) {
                            Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                            Write-Log "Use cases content migration complete." -Level "SUCCESS"
                            Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                        }
                    }
                }
            }
        }
        4 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 4: Create Year-Specific TOC and Index Files..." -Level "INFO"
                if (Execute-Phase4) {
                    Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                    $script:state.phase = 5
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase5) {
                        Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                        $script:state.phase = 6
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase6) {
                            Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                            Write-Log "Use cases content migration complete." -Level "SUCCESS"
                            Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                        }
                    }
                }
            }
            else {
                Write-Log "Phase 4 already completed. Moving to Phase 5..." -Level "INFO"
                $script:state.phase = 5
                $script:state.completed = $false
                Save-State
                if (Execute-Phase5) {
                    Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                    $script:state.phase = 6
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase6) {
                        Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                        Write-Log "Use cases content migration complete." -Level "SUCCESS"
                        Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                    }
                }
            }
        }
        5 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 5: Migrate Blog Content..." -Level "INFO"
                if (Execute-Phase5) {
                    Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                    $script:state.phase = 6
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase6) {
                        Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                        Write-Log "Use cases content migration complete." -Level "SUCCESS"
                        Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                    }
                }
            }
            else {
                Write-Log "Phase 5 already completed. Moving to Phase 6..." -Level "INFO"
                $script:state.phase = 6
                $script:state.completed = $false
                Save-State
                if (Execute-Phase6) {
                    Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                    Write-Log "Use cases content migration complete." -Level "SUCCESS"
                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                }
            }
        }
        6 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 6: Migrate Use Cases Content..." -Level "INFO"
                if (Execute-Phase6) {
                    Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                    Write-Log "Use cases content migration complete." -Level "SUCCESS"
                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                }
            }
            else {
                Write-Log "Phase 6 already completed." -Level "INFO"
                Write-Log "Use cases content migration complete." -Level "SUCCESS"
                Write-Log "To continue with the next phases, run this script again." -Level "INFO"
            }
        }
        default {
            Write-Log "Phases 1-6 already completed. Future phases will be implemented in subsequent scripts." -Level "INFO"
            Write-Log "Current phase: $($script:state.phase)" -Level "INFO"
        }
    }
}

# Start the migration
Start-Migration
