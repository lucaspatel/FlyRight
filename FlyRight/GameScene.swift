//
//  GameScene.swift
//  FlyRight
//
//  Created by Jacob Patel on 7/1/17.
//  Copyright © 2017 Jacob Patel. All rights reserved.
//
import SpriteKit

class GameScene: SKScene {
  
  // MARK: Properties
  
  // This is marked as ! because it will not initially have a value, but pretty
  // soon after the GameScene is created it will be given a Level object, and
  // from then on it will always have one (it will never be nil again).
  var level: Level!
  
  let TileWidth: CGFloat = 28
  let TileHeight: CGFloat = 28
    // orig 30-30
  
    var currTime : Date = Date()

    
  let gameLayer = SKNode()
  let spacesLayer = SKNode()
  let tilesLayer = SKNode()
  
  // MARK: Init

    // This variable will ensure a re-update every iteration.
    static var updateRequired = true
    
    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder) is not used in this app")
  }
    
  override func update(_ currentTime: TimeInterval) {
    if (currTime == nil) { currTime = Date() }
    if (NSDate().timeIntervalSince(currTime) > 0.5) {
        shuffle()
        currTime = Date()
    }
  }
    
    func shuffle() {
        removeAllSpaces()
        
    // Fill up the level with new spaces, and create sprites for them.
        let newSpaces = level.shuffle()
        addSprites(for: newSpaces)
    }
    
    // This method clears the board of all nodes.
    func removeAllSpaces() {
        spacesLayer.removeAllChildren()
    }
    
    
  override init(size: CGSize) {
    super.init(size: size)
    
    anchorPoint = CGPoint(x: 0.5, y: 0.5)
    // orig 0.5-0.5
    
    // Put an image on the background. Because the scene's anchorPoint is
    // (0.5, 0.5), the background image will always be centered on the screen.
    let background = SKSpriteNode(imageNamed: "Background")
    background.size = size
    addChild(background)
    
    // Add a new node that is the container for all other layers on the playing
    // field. This gameLayer is also centered in the screen.
    addChild(gameLayer)
    
    let layerPosition = CGPoint(
      x: -TileWidth * CGFloat(NumColumns) / 2,
      y: -TileHeight * CGFloat(NumRows) / 2)
    
    // The tiles layer represents the shape of the level. It contains a sprite
    // node for each square that is filled in.
    tilesLayer.position = layerPosition
    gameLayer.addChild(tilesLayer)
    
    // This layer holds the Space sprites. The positions of these sprites
    // are relative to the spacesLayer's bottom-left corner.
    spacesLayer.position = layerPosition
    gameLayer.addChild(spacesLayer)
  }
  
  
  // MARK: Level Setup
  
    // IMPORTANT NOTE JACOB! You deleted this line: if level.tileAt(column: column, row: row) != nil {
  func addTiles() {
    for row in 0..<NumRows {
      for column in 0..<NumColumns {
        // If there is a tile at this position, then create a new tile
        // sprite and add it to the mask layer
          let tileNode = SKSpriteNode(imageNamed: "Tile")
          tileNode.size = CGSize(width: TileWidth, height: TileHeight)
          tileNode.position = pointFor(column: column, row: row)
          tilesLayer.addChild(tileNode)
      }
    }
  }
  
  func addSprites(for spaces: Set<Space>) {
    for space in spaces {
      // Create a new sprite for the space and add it to the spacesLayer.
      let sprite = SKSpriteNode(imageNamed: space.spaceType.spriteName)
      sprite.size = CGSize(width: TileWidth, height: TileHeight)
      sprite.position = pointFor(column: space.column, row: space.row)
      spacesLayer.addChild(sprite)
      space.sprite = sprite
    }
  }
  
  
  // MARK: Point conversion
  
  // Converts a column,row pair into a CGPoint that is relative to the spaceLayer.
  func pointFor(column: Int, row: Int) -> CGPoint {
    return CGPoint(
      x: CGFloat(column)*TileWidth + TileWidth/2,
      y: CGFloat(row)*TileHeight + TileHeight/2)
  }

}

